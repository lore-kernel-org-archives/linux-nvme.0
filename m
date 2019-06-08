From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 8 Jun 2019 19:36:42 +0000
Subject: [PATCH V6 6/6] fabrics: Return errno mapped for fabrics error
 status
References: <20190604154034.23386-1-minwoo.im.dev@gmail.com>
 <20190604154034.23386-7-minwoo.im.dev@gmail.com>
Message-ID: <BYAPR04MB57497DFEEC77ED6D43998ED086110@BYAPR04MB5749.namprd04.prod.outlook.com>

On 06/04/2019 08:41 AM, Minwoo Im wrote:
> If discover has been failed due to a nvme status, it will be returned to
> main() with mapped value for fabrics get log page command.
>
> Now connect command related status cannot be added in this patch because
> kernel is not currently returning the nvme status, it's instead
> returning -EIO if fails.  errno for connect command can be added once
> kernel is ready to return the proper value for nvme status.
>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Chaitanya Kulkarni <chaitanya.Kulkarni at wdc.com>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   fabrics.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/fabrics.c b/fabrics.c
> index 7be7f59..81c2d9d 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -35,6 +35,7 @@
>
>   #include "parser.h"
>   #include "nvme-ioctl.h"
> +#include "nvme-status.h"
>   #include "fabrics.h"
>
>   #include "nvme.h"
> @@ -295,7 +296,7 @@ enum {
>   };
>
>   static int nvmf_get_log_page_discovery(const char *dev_path,
> -		struct nvmf_disc_rsp_page_hdr **logp, int *numrec)
> +		struct nvmf_disc_rsp_page_hdr **logp, int *numrec, int *status)
>   {
>   	struct nvmf_disc_rsp_page_hdr *log;
>   	unsigned int hdr_size;
> @@ -400,6 +401,7 @@ out_free_log:
>   out_close:
>   	close(fd);
>   out:
> +	*status = nvme_status_to_errno(error, true);
>   	return error;
>   }
>
> @@ -849,6 +851,7 @@ static int do_discover(char *argstr, bool connect)
>   	struct nvmf_disc_rsp_page_hdr *log = NULL;
>   	char *dev_name;
>   	int instance, numrec = 0, ret, err;
> +	int status = 0;
>
>   	instance = add_ctrl(argstr);
>   	if (instance < 0)
> @@ -856,7 +859,7 @@ static int do_discover(char *argstr, bool connect)
>
>   	if (asprintf(&dev_name, "/dev/nvme%d", instance) < 0)
>   		return -errno;
> -	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
> +	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec, &status);
>   	free(dev_name);
>   	err = remove_ctrl(instance);
>   	if (err)
> @@ -874,9 +877,11 @@ static int do_discover(char *argstr, bool connect)
>   	case DISC_GET_NUMRECS:
>   		fprintf(stderr,
>   			"Get number of discovery log entries failed.\n");
> +		ret = status;
>   		break;
>   	case DISC_GET_LOG:
>   		fprintf(stderr, "Get discovery log entries failed.\n");
> +		ret = status;
>   		break;
>   	case DISC_NO_LOG:
>   		fprintf(stdout, "No discovery log entries to fetch.\n");
> @@ -885,6 +890,7 @@ static int do_discover(char *argstr, bool connect)
>   	case DISC_NOT_EQUAL:
>   		fprintf(stderr,
>   		"Numrec values of last two get discovery log page not equal\n");
> +		ret = DISC_OK;
Can you please explain above assignment ?
>   		break;
>   	default:
>   		fprintf(stderr, "Get discovery log page failed: %d\n", ret);
> @@ -1000,7 +1006,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
>   	}
>
>   out:
> -	return ret;
> +	return nvme_status_to_errno(ret, true);
>   }
>
>   int connect(const char *desc, int argc, char **argv)
> @@ -1047,8 +1053,9 @@ int connect(const char *desc, int argc, char **argv)
>   	instance = add_ctrl(argstr);
>   	if (instance < 0)
>   		ret = instance;
> +
>   out:
> -	return ret;
> +	return nvme_status_to_errno(ret, true);
>   }
>
>   static int scan_sys_nvme_filter(const struct dirent *d)
> @@ -1181,7 +1188,7 @@ int disconnect(const char *desc, int argc, char **argv)
>   	}
>
>   out:
> -	return ret;
> +	return nvme_status_to_errno(ret, true);
>   }
>
>   int disconnect_all(const char *desc, int argc, char **argv)
> @@ -1212,5 +1219,5 @@ int disconnect_all(const char *desc, int argc, char **argv)
>   		}
>   	}
>   out:
> -	return ret;
> +	return nvme_status_to_errno(ret, true);
>   }
>
