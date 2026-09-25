Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCF4C98321
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RaaxGx7n/K5DAzGN9rDyMLhHInRN0POj9j7UDsiqwrI=; b=Ysyg+3noVigsuX09UaIZhYcjzt
	j4CybmBZbRBqETD0dRjZF263kHbGKjLWHo0mCfcI4QNHh0q7A3sJf2OIFb4O3v0NNKXjlliTWz4Zw
	/F6J6EcNBQM376MIRO2Irc7nYsrG9VfKEswVZurBQlzQnY0ZDXTyOBoUgApwwJvqsOFCj64JQZkPb
	yO/Bxhel4eZVaytma/2LfMfteK66V3/ayDw55Bx2po68l7s26IncGk2t0ce0uctae5Cx5sdfq8g1a
	39YuIdSRgyKrK3JYLQtblZgLzNrueKHPruIeFlgHr8NT7Rz+39gMInU3qT/4COmc2Lp6Ph054/Wlq
	knz+gG9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA6oc-0000000DZGg-0SK2;
	Fri, 25 Sep 2026 14:22:18 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA6oY-0000000DZG2-4BUh
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 14:22:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=9VVzFBx6Tf2YT8
	G1GrH/MXV8G27fwMnpbgNIj3OFWO4=; h=in-reply-to:references:from:subject:
	to:date; d=arkamax.eu; b=PjaNIY8tRvZPZlr5hGpNJmGCuxrwRqMMrQoYmdYqjqizb
	4+DnP5K5ZJ2MbUYAK1PLFkC17TlPXTNDwvu7/V+uYSIncZM39H5lowz+n5l95E/mgn2RMr
	o6JlPv6cHZOlO000SupX9o/ZNEuzYHhjXS5NogccQp4IDLOSJwwdg2fCcKYy6URlygVAwP
	+3U2z1sWQGPLKGhtty75dMH32o7cVdftxnm+ha0IzASZKZ0eaP/LK7Ar4M6+I6ik0HCEXM
	VfmQ1jG/7ROjrFLG5pq9s2JI9THLo/7TafsmJER4AMeOMoPGaB5Nag27R6bQsV3zbRJAvk
	bPAsZ1a/JXjTWi0Ew==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 4e614d45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 25 Sep 2026 16:22:07 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 16:22:06 +0200
Message-Id: <DLOGQG9GZC3X.1UZ2MY7S3T5N2@arkamax.eu>
To: "syzbot" <syzbot+list003bd56f9e8b27f9d049@syzkaller.appspotmail.com>,
 <hch@lst.de>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] Monthly nvme report (Sep 2026)
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.22.0
References: <6ab3569c.514bccd6.255447.0023.GAE@google.com>
In-Reply-To: <6ab3569c.514bccd6.255447.0023.GAE@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_072215_709141_B1F264F0 
X-CRM114-Status: GOOD (  19.67  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed Sep 23, 2026 at 6:33 AM CEST, syzbot wrote:
> Hello nvme maintainers/developers,
>
> Ref Crashes Repro Title
> <2> 2       Yes   KASAN: slab-use-after-free Read in nvmet_port_subsys_al=
low_link
>                   https://syzkaller.appspot.com/bug?extid=3Db0996ac2197dd=
7420c3e

I have a patch that fixes this one, but I still have to carefully test
it with blktests before submitting it:


----------

nvmet: fix null-ptr-deref and use-after-free in port configfs
 lifecycle

When concurrent threads execute rmdir on an NVMe-oF port directory
and symlink or unlink on the port's subsystems directory, a race
condition leads to kernel crashes because of NULL pointer dereferences
and UAF bugs.

There are two flaws in how the port's configfs default groups are handled
during the teardown.

The first one is a NULL pointer dereference via ci_parent: When rmdir is
called on the port, configfs sets parent->ci_parent to NULL.
If a concurrent symlink operation executes nvmet_port_subsys_allow_link()
or drop_link(), the to_nvmet_port(parent->ci_parent) calculation
subtracts the structure offset from NULL, resulting in a bogus negative
memory address and a kernel panic.

The second one is due to the configfs groups (subsystems, referrals,
ana_groups and ana_default directories) being embedded within the
nvmet_port memory allocation.
During rmdir, nvmet_port_release() executes kfree(port) immediately.
However, concurrent operations like symlinkat might still hold
active configfs references to the embedded groups. When the system
subsequently drops these references, configfs writes to the already
freed nvmet_port memory block, triggering a UAF.

Fix those bugs by decoupling the port's memory lifecycle from its
primary configfs item lifecycle and by replacing the ci_parent pointer
dereferencing:

Introduces a kref to struct nvmet_port. The kref is initialized to 5
in nvmet_ports_make() (1 for the port itself, plus 4 for its embedded
default groups). release() callbacks are added for the embedded groups
to drop their references via kref_put(). The nvmet_port memory block is
now only freed via nvmet_port_free() when all activity across all nested
directories has completely concluded.

Replaces volatile ci_parent dereferencing in nvmet_port_subsys_allow_link()
and drop_link() by using container_of() on the embedded subsys_group.

Serializes visibility of the port by moving list_add() to the very end of
port creation and list_del() to the very beginning of port teardown and
protecting it with the semaphore.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/configfs.c | 64 ++++++++++++++++++++++++++++++----
 drivers/nvme/target/nvmet.h    |  1 +
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.=
c
index 6286e38436dd..363cb800b8cd 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1056,7 +1056,8 @@ static void nvmet_add_passthru_group(struct nvmet_sub=
sys *subsys)
 static int nvmet_port_subsys_allow_link(struct config_item *parent,
 		struct config_item *target)
 {
-	struct nvmet_port *port =3D to_nvmet_port(parent->ci_parent);
+	struct nvmet_port *port =3D container_of(to_config_group(parent),
+					struct nvmet_port, subsys_group);
 	struct nvmet_subsys *subsys;
 	struct nvmet_subsys_link *link, *p;
 	int ret;
@@ -1099,7 +1100,8 @@ static int nvmet_port_subsys_allow_link(struct config=
_item *parent,
 static void nvmet_port_subsys_drop_link(struct config_item *parent,
 		struct config_item *target)
 {
-	struct nvmet_port *port =3D to_nvmet_port(parent->ci_parent);
+	struct nvmet_port *port =3D container_of(to_config_group(parent),
+					struct nvmet_port, subsys_group);
 	struct nvmet_subsys *subsys =3D to_subsys(target);
 	struct nvmet_subsys_link *p;
=20
@@ -1122,9 +1124,23 @@ static void nvmet_port_subsys_drop_link(struct confi=
g_item *parent,
 	kfree(p);
 }
=20
+static void nvmet_port_free(struct kref *ref)
+{
+	struct nvmet_port *port =3D container_of(ref, struct nvmet_port, ref);
+	key_put(port->keyring);
+	kfree(port);
+}
+
+static void nvmet_port_subsys_release(struct config_item *item)
+{
+	struct nvmet_port *port =3D container_of(to_config_group(item), struct nv=
met_port, subsys_group);
+	kref_put(&port->ref, nvmet_port_free);
+}
+
 static struct configfs_item_operations nvmet_port_subsys_item_ops =3D {
 	.allow_link		=3D nvmet_port_subsys_allow_link,
 	.drop_link		=3D nvmet_port_subsys_drop_link,
+	.release		=3D nvmet_port_subsys_release,
 };
=20
 static const struct config_item_type nvmet_port_subsys_type =3D {
@@ -1862,6 +1878,16 @@ static struct config_group *nvmet_referral_make(
 	return &port->group;
 }
=20
+static void nvmet_referrals_group_release(struct config_item *item)
+{
+	struct nvmet_port *port =3D container_of(to_config_group(item), struct nv=
met_port, referrals_group);
+	kref_put(&port->ref, nvmet_port_free);
+}
+
+static struct configfs_item_operations nvmet_referrals_item_ops =3D {
+	.release	=3D nvmet_referrals_group_release,
+};
+
 static struct configfs_group_operations nvmet_referral_group_ops =3D {
 	.make_group		=3D nvmet_referral_make,
 	.disconnect_notify	=3D nvmet_referral_notify,
@@ -1870,6 +1896,7 @@ static struct configfs_group_operations nvmet_referra=
l_group_ops =3D {
 static const struct config_item_type nvmet_referrals_type =3D {
 	.ct_owner	=3D THIS_MODULE,
 	.ct_group_ops	=3D &nvmet_referral_group_ops,
+	.ct_item_ops	=3D &nvmet_referrals_item_ops,
 };
=20
 static struct nvmet_type_name_map nvmet_ana_state[] =3D {
@@ -1930,8 +1957,10 @@ static void nvmet_ana_group_release(struct config_it=
em *item)
 {
 	struct nvmet_ana_group *grp =3D to_ana_group(item);
=20
-	if (grp =3D=3D &grp->port->ana_default_group)
+	if (grp =3D=3D &grp->port->ana_default_group) {
+		kref_put(&grp->port->ref, nvmet_port_free);
 		return;
+	}
=20
 	down_write(&nvmet_ana_sem);
 	grp->port->ana_state[grp->grpid] =3D NVME_ANA_INACCESSIBLE;
@@ -1992,8 +2021,19 @@ static struct configfs_group_operations nvmet_ana_gr=
oups_group_ops =3D {
 	.make_group		=3D nvmet_ana_groups_make_group,
 };
=20
+static void nvmet_ana_groups_release(struct config_item *item)
+{
+	struct nvmet_port *port =3D container_of(to_config_group(item), struct nv=
met_port, ana_groups_group);
+	kref_put(&port->ref, nvmet_port_free);
+}
+
+static struct configfs_item_operations nvmet_ana_groups_item_ops =3D {
+	.release	=3D nvmet_ana_groups_release,
+};
+
 static const struct config_item_type nvmet_ana_groups_type =3D {
 	.ct_group_ops		=3D &nvmet_ana_groups_group_ops,
+	.ct_item_ops		=3D &nvmet_ana_groups_item_ops,
 	.ct_owner		=3D THIS_MODULE,
 };
=20
@@ -2004,12 +2044,13 @@ static void nvmet_port_release(struct config_item *=
item)
 {
 	struct nvmet_port *port =3D to_nvmet_port(item);
=20
+	down_write(&nvmet_config_sem);
+	list_del(&port->global_entry);
+	up_write(&nvmet_config_sem);
 	/* Let inflight controllers teardown complete */
 	flush_workqueue(nvmet_wq);
-	list_del(&port->global_entry);
=20
-	key_put(port->keyring);
-	kfree(port);
+	kref_put(&port->ref, nvmet_port_free);
 }
=20
 static struct configfs_attribute *nvmet_port_attrs[] =3D {
@@ -2067,7 +2108,12 @@ static struct config_group *nvmet_ports_make(struct =
config_group *group,
 			port->ana_state[i] =3D NVME_ANA_INACCESSIBLE;
 	}
=20
-	list_add(&port->global_entry, &nvmet_ports_list);
+	/* 1 for the port itself, plus 4 for embedded default groups */
+	kref_init(&port->ref);
+	kref_get(&port->ref); /* Referrals */
+	kref_get(&port->ref); /* Subsystems */
+	kref_get(&port->ref); /* ana_grous */
+	kref_get(&port->ref); /* ana_default */
=20
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
@@ -2102,6 +2148,10 @@ static struct config_group *nvmet_ports_make(struct =
config_group *group,
 	configfs_add_default_group(&port->ana_default_group.group,
 			&port->ana_groups_group);
=20
+	down_write(&nvmet_config_sem);
+	list_add(&port->global_entry, &nvmet_ports_list);
+	up_write(&nvmet_config_sem);
+
 	return &port->group;
 }
=20
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dbda55895f4f..1c8a5e2275af 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -219,6 +219,7 @@ struct nvmet_port {
 	int				mdts;
 	const struct nvmet_fabrics_ops	*tr_ops;
 	bool				pi_enable;
+	struct kref			ref;
 	enum nvme_ana_state		ana_state[];
 };
=20
--=20
2.55.0

