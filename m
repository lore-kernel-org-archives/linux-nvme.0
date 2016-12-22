From: narayan.ayalasomayajula@kazan-networks.com (Narayan Ayalasomayajula)
Date: Thu, 22 Dec 2016 14:13:40 +0000
Subject: Enabling RoCEv2 and connecting to IPv6 targets
In-Reply-To: <5b221596-ac9a-f49a-43ea-92068706341e@grimberg.me>
References: <BY2PR08MB181560EB58B0E8DF5A944E84C09D0@BY2PR08MB1815.namprd08.prod.outlook.com>
 <5b221596-ac9a-f49a-43ea-92068706341e@grimberg.me>
Message-ID: <BY2PR08MB1815D6BDABDE0AE35A9A4C8FC0920@BY2PR08MB1815.namprd08.prod.outlook.com>

Hi Sagi,

Thanks for the pointer. I will try out these patches and will let you know how it goes.

Narayan

-----Original Message-----
From: Sagi Grimberg [mailto:sagi@lightbitslabs.com] On Behalf Of Sagi Grimberg
Sent: Thursday, December 22, 2016 5:04 AM
To: Narayan Ayalasomayajula <narayan.ayalasomayajula at kazan-networks.com>; linux-nvme at lists.infradead.org
Subject: Re: Enabling RoCEv2 and connecting to IPv6 targets



On 15/12/16 21:13, Narayan Ayalasomayajula wrote:
> All,
>
> I am attempting to enable connecting to IPv6 NVMe-oF targets (not the Linux NVMe-oF target) as well as enable RoCEv2 and have a couple of questions:
>
> 1.  With regards to IPv6, I tried the following syntax in the "echo" command (executed on a Ubuntu Host running the 4.8.0-rc22 version of the kernel) and got the following error message:
>
> 	echo "traddr=fe80::0c6:11ff:fe41:0516,transport=rdma,trsvcid=4420,nqn=nqn.kazannet.0" > /dev/nvme-fabrics
> 	bash: echo: write error: Invalid argument
>
> 	dmesg log indicates:
>
> 	nvme_rdma: malformed IP address passed: fe80::0c6:11ff:fe41:0516
>
> Is the support for connecting to IPv6 NVMe-oF targets not available in  the 4.8 version of the kernel?
>
> 2.  With regards to RoCEv2, I need to select/configure the appropriate GID on the Host NVMe-oF network interface but have not found a way to do so. I see the following example for IB at (https://community.mellanox.com/docs/DOC-2415):
>
> 	ib_send_bw -x 1
>
> How do I do this for NVMe-oF?
>
> Sorry if I am missing something very obvious - any guidance is appreciated.

Hi Narayan,

You're not missing anything obvious.

We actually had this discussion and proposed some patches to add ipv6 support, see thread at:
http://lists.infradead.org/pipermail/linux-nvme/2016-July/thread.html#5572

starts with "[PATCH 2/2] nvme-rdma: Add handling for connecting to IPv6 targets".

I recall that the conclusion was to come up with a generic addition.

CC'ing Roland...

Can you try with the below three patches applied?

[1] host side:
--
From: Roland Dreier <roland@purestorage.com>

If a target address does not parse as IPv4, try parsing it as IPv6 (including handling '%<scope-id>' suffixes for link-local addresses).

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
  drivers/nvme/host/rdma.c | 55 
++++++++++++++++++++++++++++++++++++++----------
  1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c index b96b88369871..dd4aa54cd709 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -138,6 +138,7 @@ struct nvme_rdma_ctrl {
  	union {
  		struct sockaddr addr;
  		struct sockaddr_in addr_in;
+		struct sockaddr_in6 addr_in6;
  	};

  	struct nvme_ctrl	ctrl;
@@ -1847,19 +1848,51 @@ out_free_io_queues:
  	return ret;
  }

-static int nvme_rdma_parse_ipaddr(struct sockaddr_in *in_addr, char *p)
+static int nvme_rdma_parse_ipaddr(struct sockaddr *addr, char *p)
  {
-	u8 *addr = (u8 *)&in_addr->sin_addr.s_addr;
  	size_t buflen = strlen(p);

-	/* XXX: handle IPv6 addresses */
+	if (buflen <= INET_ADDRSTRLEN) {
+		struct sockaddr_in *addr4 = (struct sockaddr_in *) addr;
+		if (in4_pton(p, buflen, (u8 *) &addr4->sin_addr.s_addr,
+			     '\0', NULL) > 0) {
+			addr4->sin_family = AF_INET;
+			return 0;
+		}
+	}

-	if (buflen > INET_ADDRSTRLEN)
-		return -EINVAL;
-	if (in4_pton(p, buflen, addr, '\0', NULL) == 0)
-		return -EINVAL;
-	in_addr->sin_family = AF_INET;
-	return 0;
+	if (buflen <= INET6_ADDRSTRLEN) {
+		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *) addr;
+		const char *scope_delim;
+
+		if (in6_pton(p, buflen, (u8 *) &addr6->sin6_addr.s6_addr,
+			     '%', &scope_delim) == 0)
+			return -EINVAL;
+		addr6->sin6_family = AF_INET6;
+
+		if (ipv6_addr_type(&addr6->sin6_addr) & IPV6_ADDR_LINKLOCAL &&
+		    p + buflen != scope_delim && *scope_delim == '%') {
+			char scope_id[16];
+			size_t scope_len = min_t(size_t, sizeof scope_id,
+						 p + buflen - scope_delim - 1);
+			struct net_device *dev;
+
+			memcpy(scope_id, scope_delim + 1, scope_len);
+			scope_id[scope_len] = '\0';
+
+			/* XXX: what network namespace should we use? */
+			dev = dev_get_by_name(&init_net, scope_id);
+			if (dev) {
+				addr6->sin6_scope_id = dev->ifindex;
+				dev_put(dev);
+			} else if (kstrtouint(scope_id, 0, &addr6->sin6_scope_id))
+				return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	return -EINVAL;
  }

  static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev, @@ -1875,7 +1908,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
  	ctrl->ctrl.opts = opts;
  	INIT_LIST_HEAD(&ctrl->list);

-	ret = nvme_rdma_parse_ipaddr(&ctrl->addr_in, opts->traddr);
+	ret = nvme_rdma_parse_ipaddr(&ctrl->addr, opts->traddr);
  	if (ret) {
  		pr_err("malformed IP address passed: %s\n", opts->traddr);
  		goto out_free_ctrl;
@@ -1949,7 +1982,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
  	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
  	WARN_ON_ONCE(!changed);

-	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
+	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
  		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);

  	kref_get(&ctrl->ctrl.kref);
-- 

[2] target side:
--
commit 068d8e511d9a6927721bddfd545ad4976196297d
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Sun Jul 31 13:45:44 2016 +0300

      nvmet-rdma: Add ipv6 support

      Allow the nvme-rdma target accept connections using
      ipv6 address resolution.

      Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c index 4e83d92d6bdd..347cc6d37dad 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1336,29 +1336,65 @@ restart:
          mutex_unlock(&nvmet_rdma_queue_mutex);
   }

-static int nvmet_rdma_add_port(struct nvmet_port *port)
+static int nvmet_rdma_set_addr_port(int family, char *ipaddr,
+               char *ipport, struct sockaddr_storage *addr)
   {
-       struct rdma_cm_id *cm_id;
-       struct sockaddr_in addr_in;
-       u16 port_in;
-       int ret;
+       size_t buflen = strlen(ipaddr);
+       struct sockaddr_in *addr4;
+       struct sockaddr_in6 *addr6;
+       u16 port;
+
+       if (kstrtou16(ipport, 0, &port))
+               return -EINVAL;

-       switch (port->disc_addr.adrfam) {
+       switch (family) {
          case NVMF_ADDR_FAMILY_IP4:
+               if (buflen > INET_ADDRSTRLEN)
+                       return -EINVAL;
+
+               addr4 = (struct sockaddr_in *)addr;
+
+               if (in4_pton(ipaddr, buflen, (u8 *)&addr4->sin_addr.s_addr,
+                            '\n', NULL) == 0)
+                       return -EINVAL;
+
+               addr4->sin_family = AF_INET;
+               addr4->sin_port = htons(port);
+               break;
+       case NVMF_ADDR_FAMILY_IP6:
+               if (buflen > INET6_ADDRSTRLEN)
+                       return -EINVAL;
+
+               addr6 = (struct sockaddr_in6 *) addr;
+
+               if (in6_pton(ipaddr, buflen, (u8
*)&addr6->sin6_addr.s6_addr,
+                            '\n', NULL) == 0)
+                       return -EINVAL;
+
+               addr6->sin6_family = AF_INET6;
+               addr6->sin6_port = htons(port);
                  break;
          default:
-               pr_err("address family %d not supported\n",
-                               port->disc_addr.adrfam);
+               pr_err("address family %d not supported\n", family);
                  return -EINVAL;
          }

-       ret = kstrtou16(port->disc_addr.trsvcid, 0, &port_in);
-       if (ret)
-               return ret;
+       return 0;
+}

-       addr_in.sin_family = AF_INET;
-       addr_in.sin_addr.s_addr = in_aton(port->disc_addr.traddr);
-       addr_in.sin_port = htons(port_in);
+static int nvmet_rdma_add_port(struct nvmet_port *port) {
+       struct rdma_cm_id *cm_id;
+       struct sockaddr_storage addr = { };
+       int ret;
+
+       ret = nvmet_rdma_set_addr_port(port->disc_addr.adrfam,
+               port->disc_addr.traddr, port->disc_addr.trsvcid, &addr);
+       if (ret) {
+               pr_err("failed setting addr %s:%s\n",
+               port->disc_addr.traddr, port->disc_addr.trsvcid);
+               return ret;
+       }

          cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
                          RDMA_PS_TCP, IB_QPT_RC); @@ -1367,20 +1403,33 @@ static int nvmet_rdma_add_port(struct nvmet_port
*port)
                  return PTR_ERR(cm_id);
          }

-       ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr_in);
+       /*
+        * Allow both IPv4 and IPv6 sockets to bind a single port
+        * at the same time.
+        */
+       ret = rdma_set_afonly(cm_id, 1);
+       if (ret) {
+               pr_err("rdma_set_afonly failed (%d)\n", ret);
+               goto out_destroy_id;
+       }
+
+       ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
          if (ret) {
-               pr_err("binding CM ID to %pISpc failed (%d)\n",
&addr_in, ret);
+               pr_err("binding CM ID to %pISpcs failed (%d)\n",
+                       (struct sockaddr *)&addr, ret);
                  goto out_destroy_id;
          }

          ret = rdma_listen(cm_id, 128);
          if (ret) {
-               pr_err("listening to %pISpc failed (%d)\n", &addr_in, ret);
+               pr_err("listening to %pISpcs failed (%d)\n",
+                       (struct sockaddr *)&addr, ret);
                  goto out_destroy_id;
          }

-       pr_info("enabling port %d (%pISpc)\n",
-               le16_to_cpu(port->disc_addr.portid), &addr_in);
+       pr_info("enabling port %d (%pISpcs)\n",
+               le16_to_cpu(port->disc_addr.portid),
+               (struct sockaddr *)&addr);
          port->priv = cm_id;
          return 0;
--

[3] nvme-cli:
--
commit 6d962c76580680e9cd0f5a56f47bcd30b5a39dd7
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Sun Jul 31 13:56:58 2016 +0300

      fabrics: Allow ipv6 address resolution

      Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

diff --git a/fabrics.c b/fabrics.c
index 4bf557b5e672..221e34e5e39b 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -390,7 +390,8 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
                  /* we can safely ignore the rest of the entries */
                  break;
          case NVMF_TRTYPE_RDMA:
-               if (e->adrfam != NVMF_ADDR_FAMILY_IP4) {
+               if (e->adrfam != NVMF_ADDR_FAMILY_IP4 &&
+                   e->adrfam != NVMF_ADDR_FAMILY_IP6) {
                          fprintf(stderr, "skipping unsupported adrfam\n");
                          return -EINVAL;
                  }
--
