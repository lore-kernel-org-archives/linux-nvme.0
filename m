From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 7 May 2019 12:17:03 +0300
Subject: [PATCH nvme-cli rfc 1/6] fabrics: ignore arguments that pass in
 "none"
In-Reply-To: <20190223023257.21227-2-sagi@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <20190223023257.21227-2-sagi@grimberg.me>
Message-ID: <cd812103-3023-4563-2be8-3d22e85e5389@mellanox.com>


On 2/23/2019 4:32 AM, Sagi Grimberg wrote:
> As we want to support discovery uevents over different
> transports, we want to allow the kernel to provide missing
> information in the form of none and have nvme-cli properly
> ignore it.
>
> One example is the host_traddr. If it is not set (which means
> that the default route determined the host address) we will
> want to do the same for newly discovered controllers.
>
> So allow users to pass 'none' arguments as well.

can you please add an example for the command in the commit message ?


>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   fabrics.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fabrics.c b/fabrics.c
> index f5cd2127db05..ad9a15e72070 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -565,7 +565,7 @@ add_argument(char **argstr, int *max_len, char *arg_str, char *arg)
>   {
>   	int len;
>   
> -	if (arg) {
> +	if (arg && strcmp(arg, "none")) {
>   		len = snprintf(*argstr, *max_len, ",%s=%s", arg_str, arg);
>   		if (len < 0)
>   			return -EINVAL;
> @@ -658,14 +658,14 @@ retry:
>   		return -EINVAL;
>   	p += len;
>   
> -	if (cfg.hostnqn) {
> +	if (cfg.hostnqn && strcmp(cfg.hostnqn, "none")) {
>   		len = sprintf(p, ",hostnqn=%s", cfg.hostnqn);
>   		if (len < 0)
>   			return -EINVAL;
>   		p += len;
>   	}
>   
> -	if (cfg.hostid) {
> +	if (cfg.hostid && strcmp(cfg.hostnqn, "none")) {

c&p bug here ?


>   		len = sprintf(p, ",hostid=%s", cfg.hostid);
>   		if (len < 0)
>   			return -EINVAL;
> @@ -700,7 +700,7 @@ retry:
>   		p += len;
>   	}
>   
> -	if (cfg.host_traddr) {
> +	if (cfg.host_traddr && strcmp(cfg.host_traddr, "none")) {
>   		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
>   		if (len < 0)
>   			return -EINVAL;
