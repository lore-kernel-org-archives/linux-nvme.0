From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 2 Jul 2018 10:31:29 -0500
Subject: [PATCH] Support inline_data_size port parameter
In-Reply-To: <20180702152948.9D0362B88F@smtp.opengridcomputing.com>
References: <20180702152948.9D0362B88F@smtp.opengridcomputing.com>
Message-ID: <0de0700b-0343-d22a-a525-12d6eb1d46c7@opengridcomputing.com>

Oops: forgot to add "nvmetcli" in the subject.

Steve.


On 7/2/2018 10:25 AM, Steve Wise wrote:
> The port parameter attribute param_inline_data_size allows adjusting
> the amount of inline data that can be included in a write IO. Setting
> it to < 0 (or not setting it at all) allows the transport to choose a
> reasonable default, which will be 0 if that transport does not support
> inline.  Setting it to 0 disables the transport from using inline_data.
> And setting it to > 0 configures that port/transport to use that inline
> data size, in bytes, if the transport supports it.
>
> Signed_off_by: Steve Wise <swise at opengridcomputing.com>
> ---
>  nvmet/nvme.py | 4 ++--
>  nvmetcli      | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 8253ea9264b7..1aac7bc3fea3 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -609,7 +609,7 @@ class Port(CFSNode):
>      def __init__(self, portid, mode='any'):
>          super(Port, self).__init__()
>  
> -        self.attr_groups = ['addr']
> +        self.attr_groups = ['addr', 'param']
>          self._portid = int(portid)
>          self._path = "%s/ports/%d" % (self.configfs_dir, self._portid)
>          self._create_in_cfs(mode)
> @@ -710,7 +710,7 @@ class Referral(CFSNode):
>          if not isinstance(port, Port):
>              raise CFSError("Invalid parent class")
>  
> -        self.attr_groups = ['addr']
> +        self.attr_groups = ['addr', 'param']
>          self.port = port
>          self._name = name
>          self._path = "%s/referrals/%s" % (self.port.path, self._name)
> diff --git a/nvmetcli b/nvmetcli
> index 6b102a235450..16528ace61ea 100755
> --- a/nvmetcli
> +++ b/nvmetcli
> @@ -374,6 +374,9 @@ class UIPortNode(UINode):
>          'trsvcid': ('string', 'Transport Service ID (e.g. IP Port)'),
>          'trtype': ('string', 'Transport Type (e.g. rdma or loop or fc)'),
>      }
> +    ui_desc_param = {
> +        'inline_data_size': ('string', 'Port inline data size in bytes'),
> +    }
>  
>      def __init__(self, parent, cfnode):
>          UINode.__init__(self, str(cfnode.portid), parent, cfnode)
> @@ -387,6 +390,7 @@ class UIPortNode(UINode):
>          trsvcid = self.cfnode.get_attr("addr", "trsvcid")
>          if trsvcid != "none":
>              info.append("trsvcid=%s" % trsvcid)
> +        info.append("inline_data_size=" + self.cfnode.get_attr("param", "inline_data_size"))
>          enabled = not (not self.cfnode.subsystems and not list(self.cfnode.referrals))
>          return (", ".join(info), True if enabled else 0)
>  
> @@ -493,6 +497,9 @@ class UIReferralNode(UINode):
>          'trtype': ('string', 'Transport Type (e.g. rdma or loop or fc)'),
>          'portid': ('number', 'Port identifier'),
>      }
> +    ui_desc_param = {
> +        'inline_data_size': ('string', 'Port inline data size in bytes'),
> +    }
>  
>      def __init__(self, parent, cfnode):
>          UINode.__init__(self, cfnode.name, parent, cfnode)


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
