From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 10:07:04 +0300
Subject: [PATCH] Adds the appility to print json to stdout, create ports, 
 namespaces and subsystems using cli.
In-Reply-To: <1531663895-5151-1-git-send-email-hamdyk@mellanox.com>
References: <1531663895-5151-1-git-send-email-hamdyk@mellanox.com>
Message-ID: <739dae37-0c4a-aa23-a8c7-8969bbf972b2@grimberg.me>

This patch needs to split into at least 2 patches.

On 07/15/2018 05:11 PM, Hamdy Khader wrote:
> ---
>   nvmet/nvme.py |  3 +++
>   nvmetcli      | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 8253ea9..3ca8429 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -388,6 +388,9 @@ class Root(CFSNode):
>           d['hosts'] = [h.dump() for h in self.hosts]
>           return d
>   
> +    def dump_json(self):
> +        return json.dumps(self.dump(), sort_keys=True, indent=2)
> +
>   
>   class Subsystem(CFSNode):
>       '''
> diff --git a/nvmetcli b/nvmetcli
> index 6b102a2..b784162 100755
> --- a/nvmetcli
> +++ b/nvmetcli
> @@ -583,6 +583,12 @@ def usage():
>       print("        %s restore [file_to_restore_from]" % sys.argv[0])
>       print("        %s clear" % sys.argv[0])
>       print("        %s ls" % sys.argv[0])
> +    print("        %s create_port [subsystem_name] [port_id] [ip_version]" % sys.argv[0])
> +    print("                       [transport_address] [transport_type] [transport_port]")

If we go down this route, then subsystem linkage should be a separate
command.

> +    print("        %s create_subsystem [subsystem_name]" % sys.argv[0])

What about remove_port/remove_subsystem?

> +    print("        %s create_ns [namespace_id] [subsystem_name] [device_path]" % sys.argv[0])
> +    print("        %s delete_ns [namespace_id] [subsystem_name]" % sys.argv[0])
> +    print("        %s dump" % sys.argv[0])
>       sys.exit(-1)
