From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 23 Aug 2016 16:42:04 -0700
Subject: [PATCH] nvme-cli/fabrics: Added hostnqn parameter to connect
 command
In-Reply-To: <1471946706-18036-1-git-send-email-roysh@mellanox.com>
References: <1471946706-18036-1-git-send-email-roysh@mellanox.com>
Message-ID: <1471995724.23443.32.camel@linux.intel.com>

On Tue, 2016-08-23@13:05 +0300, Roy Shterman wrote:
> Added user-defined 'hostnqn' to 'connect' command
> so users could use the allowed_hosts attribute on the target and
> still
> connect to target with nvme-cli tool.
> 
> usage examples:
> 	nvme discover -t <TRANSPORT> -a <ADDRESS> -s <SERVICE_ID> -q
> <USER-DEFINED_HOSTNQN>

I believe the example needs to be changed from 'discover' to 'connect'
;-)

Jay

> 
> Signed-off-by: Roy Shterman <roysh at mellanox.com>
> ---
> ?fabrics.c |????2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/fabrics.c b/fabrics.c
> index 26c4e22..942e987 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -711,6 +711,8 @@ int connect(const char *desc, int argc, char
> **argv)
> ?			"transport address" },
> ?		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid,
> required_argument,
> ?			"transport service id (e.g. IP port)" },
> +		{"hostnqn", 'q', "LIST", CFG_STRING, &cfg.hostnqn,
> required_argument,
> +			"user-defined hostnqn" },
> ?		{0},
> ?	};
> ?
