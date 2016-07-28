From: roysh@mellanox.com (Roy Shterman)
Date: Thu, 28 Jul 2016 23:20:15 +0300
Subject: [PATCH] nvme-cli: user-defined hostnqn option for discover
In-Reply-To: <1469736200-6618-2-git-send-email-james_p_freyensee@linux.intel.com>
References: <1469736200-6618-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1469736200-6618-2-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <c6c9f9d8-7e02-70da-5972-28f8f9c6550c@mellanox.com>

Hi Jay,


Hi Jay,

Actually I planned to send the same patch tomorrow,

I think we should add user-defined hostnqn parameter into 'connect' command.


On 7/28/2016 11:03 PM, Jay Freyensee wrote:
> The nvme-cli will always use the default hostnqn
> in /dev/nvme-fabrics  for the discovery query, even though
> both the NVMe Target and NVMe Host rdma implementations allow
> user-defined hostnqn naming.
>
> For example, this is the current, somewhat broken behavior if you
> used your own hostnqn provision naming on the NVMe kernel target:
>
> nvme discover /dev/nvme-fabrics  -t rdma --traddr=192.168.1.3 --trsvcid=4420
>
> in dmesg:
> [591910.025779] nvme nvme0: Connect Invalid Data Parameter, hostnqn "nqn.2014-08.org.nvmexpress:NVMf:uuid:a2d7752c-a31b-477a-a003-31a5e1c424a9"
>
> New, fixed behavior introduced by this patch:
>
> [root at fedora23-fabrics-host1 nvme-cli]# nvme discover  -t rdma --traddr=192.168.1.3 --trsvcid=4420 --hostnqn=host1-rogue-nqn
>
> Discovery Log Number of Records 1, Generation counter 10
> =====Discovery Log Entry 0======
> trtype:  ipv4
> adrfam:  rdma
> nqntype: 2
> treq:    0
> portid:  1
> trsvcid: 4420
> subnqn:  nullside-nqn
> traddr:  192.168.1.3
> rdma_prtype: 0
> rdma_qptype: 0
> rdma_cms:    0
> rdma_pkey: 0x0000
> [root at fedora23-fabrics-host1 nvme-cli]#
>
> Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> ---
>   fabrics.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/fabrics.c b/fabrics.c
> index 3666a01..41a80df 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -49,6 +49,7 @@ struct config {
>   	char *transport;
>   	char *traddr;
>   	char *trsvcid;
> +	char *hostnqn;
>   	char *raw;
>   	char *device;
>   } cfg = { 0 };
> @@ -395,6 +396,14 @@ static int build_options(char *argstr, int max_len)
>   		max_len -= len;
>   	}
>   
> +	if (cfg.hostnqn) {
> +		len = snprintf(argstr, max_len, ",hostnqn=%s", cfg.hostnqn);
> +		if (len < 0)
> +			return -EINVAL;
> +		argstr += len;
> +		max_len -= len;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -525,6 +534,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
>   			"transport address" },
>   		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
>   			"transport service id (e.g. IP port)" },
> +		{"hostnqn", 'h', "LIST", CFG_STRING, &cfg.hostnqn, required_argument,
> +			"user-defined hostnqn (if default not used)" },

I believe 'h' short option is already dedicated for help parameter.
maybe we should change it to different character?

>   		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw, required_argument,
>   			"raw output file" },
>   		{0},
