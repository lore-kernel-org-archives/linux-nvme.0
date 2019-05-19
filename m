From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 May 2019 17:41:42 +0000
Subject: [PATCH V2 3/4] nvme: Return errno mapped for nvme error status
References: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
 <20190513170342.9497-4-minwoo.im.dev@gmail.com>
Message-ID: <BYAPR04MB574936E1FDF464243691513286050@BYAPR04MB5749.namprd04.prod.outlook.com>

On 05/13/2019 10:05 AM, Minwoo Im wrote:
> If ioctl module has returned a nvme error status, it will be returned
> by being converted to a mapped errno value which has been provided by
> previous commits.
>
> Cc: Keith Busch <keith.busch at intel.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   nvme.c | 180 +++++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 110 insertions(+), 70 deletions(-)
>
> diff --git a/nvme.c b/nvme.c
> index 220fb18..2e1ce4f 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -48,6 +48,7 @@
>   #include "common.h"
>   #include "nvme-print.h"
>   #include "nvme-ioctl.h"
> +#include "nvme-status.h"
>   #include "nvme-lightnvm.h"
>   #include "plugin.h"
>
> @@ -213,9 +214,10 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
>   		else
>   			show_smart_log(&smart_log, cfg.namespace_id, devicename);
>   	}
> -	else if (err > 0)
> +	else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("smart log");
>
>    close_fd:
> @@ -286,9 +288,10 @@ static int get_ana_log(int argc, char **argv, struct command *cmd,
>   			json_ana_log(ana_log, devicename);
>   		else
>   			show_ana_log(ana_log, devicename);
> -	} else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("ana-log");
>   	free(ana_log);
>   close_fd:
> @@ -364,6 +367,7 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
>   		perror("get-telemetry-log");
>   	else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
>   		fprintf(stderr, "Failed to acquire telemetry header %d!\n", err);

Following line to nvme_status_to_errno() call above assumes that err has 
a return value from nvme_get_telemetry_log() and we are overwriting it.

We need to avoid such scenarios going forward. Also, since each command 
assumes that err holds the NVMe status. Instead of having to call 
nvme_status_errno() along with nvme_show_status() we should call 
nvme_status_to_errno(err) at the end of the function in the return 
statement. This approach will not break the assumption that code is 
having now and less lines of code changes, obviously 
nvme_status_to_errno() will need some modifications but that
is fine, untested patch following  :-

diff --git a/nvme.c b/nvme.c
index e0f7552..0dd4f18 100644
--- a/nvme.c
+++ b/nvme.c
@@ -220,7 +220,7 @@ static int get_smart_log(int argc, char **argv, 
struct command *cmd, struct plug
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_ana_log(int argc, char **argv, struct command *cmd,
@@ -292,7 +292,7 @@ static int get_ana_log(int argc, char **argv, struct 
command *cmd,
         free(ana_log);
  close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_telemetry_log(int argc, char **argv, struct command 
*cmd, struct plugin *plugin)
@@ -419,7 +419,7 @@ static int get_telemetry_log(int argc, char **argv, 
struct command *cmd, struct
         free(page_log);
   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_endurance_log(int argc, char **argv, struct command 
*cmd, struct plugin *plugin)
@@ -473,7 +473,7 @@ static int get_endurance_log(int argc, char **argv, 
struct command *cmd, struct

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_effects_log(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -535,7 +535,7 @@ static int get_effects_log(int argc, char **argv, 
struct command *cmd, struct pl

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_error_log(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -619,7 +619,7 @@ static int get_error_log(int argc, char **argv, 
struct command *cmd, struct plug

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_fw_log(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -673,7 +673,7 @@ static int get_fw_log(int argc, char **argv, struct 
command *cmd, struct plugin

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_changed_ns_list_log(int argc, char **argv, struct 
command *cmd, struct plugin *plugin)
@@ -729,7 +729,7 @@ static int get_changed_ns_list_log(int argc, char 
**argv, struct command *cmd, s
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_log(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -828,7 +828,7 @@ static int get_log(int argc, char **argv, struct 
command *cmd, struct plugin *pl

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int sanitize_log(int argc, char **argv, struct command 
*command, struct plugin *plugin)
@@ -943,7 +943,7 @@ static int list_ctrl(int argc, char **argv, struct 
command *cmd, struct plugin *

         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int list_ns(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -987,7 +987,7 @@ static int list_ns(int argc, char **argv, struct 
command *cmd, struct plugin *pl

         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_nsid(int fd)
@@ -1059,7 +1059,7 @@ static int delete_ns(int argc, char **argv, struct 
command *cmd, struct plugin *
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int nvme_attach_ns(int argc, char **argv, int attach, const 
char *desc, struct command *cmd)
@@ -1124,7 +1124,7 @@ static int nvme_attach_ns(int argc, char **argv, 
int attach, const char *desc, s
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int attach_ns(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -1216,7 +1216,7 @@ static int create_ns(int argc, char **argv, struct 
command *cmd, struct plugin *
                                 fprintf(stderr, "identify failed\n");
                                 show_nvme_status(err);
                         }
-                       return err;
+                       return nvme_status_to_errno(err);
                 }
                 for (i = 0; i < 16; ++i) {
                         if ((1 << ns.lbaf[i].ds) == cfg.bs && 
ns.lbaf[i].ms == 0) {
@@ -1247,7 +1247,7 @@ static int create_ns(int argc, char **argv, struct 
command *cmd, struct plugin *

         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  char *nvme_char_from_block(char *block)
@@ -1935,7 +1935,7 @@ int __id_ctrl(int argc, char **argv, struct 
command *cmd, struct plugin *plugin,
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int id_ctrl(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -2016,7 +2016,7 @@ static int ns_descs(int argc, char **argv, struct 
command *cmd, struct plugin *p
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int id_ns(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -2103,7 +2103,7 @@ static int id_ns(int argc, char **argv, struct 
command *cmd, struct plugin *plug
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int id_nvmset(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -2161,7 +2161,7 @@ static int id_nvmset(int argc, char **argv, struct 
command *cmd, struct plugin *
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_ns_id(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -2249,7 +2249,7 @@ static int virtual_mgmt(int argc, char **argv, 
struct command *cmd, struct plugi
                 perror("virt-mgmt");

         close(fd);
-       return err;
+       return nvme_status_to_errno(err);

  }

@@ -2326,7 +2326,7 @@ static int list_secondary_ctrl(int argc, char 
**argv, struct command *cmd, struc
  close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int device_self_test(int argc, char **argv, struct command 
*cmd, struct plugin *plugin)
@@ -2374,7 +2374,7 @@ static int device_self_test(int argc, char **argv, 
struct command *cmd, struct p
                 perror("Device self-test");

         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int self_test_log(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -2430,7 +2430,7 @@ static int self_test_log(int argc, char **argv, 
struct command *cmd, struct plug
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_feature(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -2561,7 +2561,7 @@ static int get_feature(int argc, char **argv, 
struct command *cmd, struct plugin
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int fw_download(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -2666,7 +2666,7 @@ static int fw_download(int argc, char **argv, 
struct command *cmd, struct plugin
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static char *nvme_fw_status_reset_type(__u32 status)
@@ -2759,7 +2759,7 @@ static int fw_commit(int argc, char **argv, struct 
command *cmd, struct plugin *
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int subsystem_reset(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -2787,7 +2787,7 @@ static int subsystem_reset(int argc, char **argv, 
struct command *cmd, struct pl
         }

         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int reset(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -2811,7 +2811,7 @@ static int reset(int argc, char **argv, struct 
command *cmd, struct plugin *plug
         }

         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int ns_rescan(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -2835,7 +2835,7 @@ static int ns_rescan(int argc, char **argv, struct 
command *cmd, struct plugin *
         }

         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int sanitize(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -3000,7 +3000,7 @@ static int show_registers(int argc, char **argv, 
struct command *cmd, struct plu
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int get_property(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -3052,7 +3052,7 @@ static int get_property(int argc, char **argv, 
struct command *cmd, struct plugi
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int set_property(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -3107,7 +3107,7 @@ static int set_property(int argc, char **argv, 
struct command *cmd, struct plugi
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int format(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -3198,7 +3198,7 @@ static int format(int argc, char **argv, struct 
command *cmd, struct plugin *plu
                                 fprintf(stderr, "identify failed\n");
                                 show_nvme_status(err);
                         }
-                       return err;
+                       return nvme_status_to_errno(err);
                 }
                 prev_lbaf = ns.flbas & 0xf;

@@ -3265,7 +3265,7 @@ static int format(int argc, char **argv, struct 
command *cmd, struct plugin *plu
   close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int set_feature(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -3384,7 +3384,7 @@ static int set_feature(int argc, char **argv, 
struct command *cmd, struct plugin
                 free(buf);
   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int sec_send(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -3480,7 +3480,7 @@ static int sec_send(int argc, char **argv, struct 
command *cmd, struct plugin *p
         close(sec_fd);
   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int dir_send(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -3631,7 +3631,7 @@ free:
                 free(buf);
  close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int write_uncor(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -3686,7 +3686,7 @@ static int write_uncor(int argc, char **argv, 
struct command *cmd, struct plugin
  close_fd:
         close(fd);

-       return err;
+       return nvme_status_to_errno(err);
  }

  static int write_zeroes(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -3777,7 +3777,7 @@ static int write_zeroes(int argc, char **argv, 
struct command *cmd, struct plugi

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int dsm(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -3877,7 +3877,7 @@ static int dsm(int argc, char **argv, struct 
command *cmd, struct plugin *plugin

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int flush(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -3924,7 +3924,7 @@ static int flush(int argc, char **argv, struct 
command *cmd, struct plugin *plug
                 printf("NVMe Flush: success\n");
  close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int resv_acquire(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -3998,7 +3998,7 @@ static int resv_acquire(int argc, char **argv, 
struct command *cmd, struct plugi

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int resv_register(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -4075,7 +4075,7 @@ static int resv_register(int argc, char **argv, 
struct command *cmd, struct plug

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int resv_release(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -4148,7 +4148,7 @@ static int resv_release(int argc, char **argv, 
struct command *cmd, struct plugi

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int resv_report(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -4242,7 +4242,7 @@ static int resv_report(int argc, char **argv, 
struct command *cmd, struct plugin

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int submit_io(int opcode, char *command, const char *desc,
@@ -4487,7 +4487,7 @@ static int submit_io(int opcode, char *command, 
const char *desc,
         close(dfd);
   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int compare(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -4593,7 +4593,7 @@ static int sec_recv(int argc, char **argv, struct 
command *cmd, struct plugin *p

   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int dir_receive(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)
@@ -4723,7 +4723,7 @@ free:
                 free(buf);
  close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int passthru(int argc, char **argv, int ioctl_cmd, const char 
*desc, struct command *cmd)
@@ -4923,7 +4923,7 @@ static int passthru(int argc, char **argv, int 
ioctl_cmd, const char *desc, stru
                 close(wfd);
   close_fd:
         close(fd);
-       return err;
+       return nvme_status_to_errno(err);
  }

  static int io_passthru(int argc, char **argv, struct command *cmd, 
struct plugin *plugin)





>   		goto close_output;
>   	}
> @@ -402,6 +406,7 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
>   		} else if (err > 0) {
>   			fprintf(stderr, "Failed to acquire full telemetry log!\n");
>   			show_nvme_status(err);
> +			err = nvme_status_to_errno(err, false);
>   			break;
>   		}
>
> @@ -467,9 +472,10 @@ static int get_endurance_log(int argc, char **argv, struct command *cmd, struct
>   			json_endurance_log(&endurance_log, cfg.group_id, devicename);
>   		else
>   			show_endurance_log(&endurance_log, cfg.group_id, devicename);
> -	} else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("endurance log");
>
>    close_fd:
> @@ -528,10 +534,10 @@ static int get_effects_log(int argc, char **argv, struct command *cmd, struct pl
>   			json_effects_log(&effects, devicename);
>   		else
>   			show_effects_log(&effects, flags);
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("effects log page");
>
>    close_fd:
> @@ -610,10 +616,10 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
>   				json_error_log(err_log, cfg.log_entries, devicename);
>   			else
>   				show_error_log(err_log, cfg.log_entries, devicename);
> -		}
> -		else if (err > 0)
> +		} else if (err > 0) {
>   			show_nvme_status(err);
> -		else
> +			err = nvme_status_to_errno(err, false);
> +		} else
>   			perror("error log");
>   		free(err_log);
>   	}
> @@ -666,10 +672,10 @@ static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin
>   			json_fw_log(&fw_log, devicename);
>   		else
>   			show_fw_log(&fw_log, devicename);
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("fw log");
>
>    close_fd:
> @@ -722,9 +728,10 @@ static int get_changed_ns_list_log(int argc, char **argv, struct command *cmd, s
>   			json_changed_ns_list_log(&changed_ns_list_log, devicename);
>   		else
>   			show_changed_ns_list_log(&changed_ns_list_log, devicename);
> -	} else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("changed ns list log");
>
>    close_fd:
> @@ -820,9 +827,10 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
>   				d(log, cfg.log_len, 16, 1);
>   			} else
>   				d_raw((unsigned char *)log, cfg.log_len);
> -		} else if (err > 0)
> +		} else if (err > 0) {
>   			show_nvme_status(err);
> -		else
> +			err = nvme_status_to_errno(err, false);
> +		} else
>   			perror("log page");
>   		free(log);
>   	}
> @@ -883,10 +891,10 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
>   			json_sanitize_log(&sanitize_log, devicename);
>   		else
>   			show_sanitize_log(&sanitize_log, flags, devicename);
> -	}
> -	else if (ret > 0)
> +	} else if (ret > 0) {
>   		show_nvme_status(ret);
> -	else
> +		ret = nvme_status_to_errno(ret, false);
> +	} else
>   		perror("sanitize status log");
>
>    close_fd:
> @@ -934,10 +942,10 @@ static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *
>
>   		for (i = 0; i < (min(num, 2048)); i++)
>   			printf("[%4u]:%#x\n", i, le16_to_cpu(cntlist->identifier[i]));
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("id controller list");
>
>   	free(cntlist);
> @@ -980,10 +988,10 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
>   		for (i = 0; i < 1024; i++)
>   			if (ns_list[i])
>   				printf("[%4u]:%#x\n", i, le32_to_cpu(ns_list[i]));
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("id namespace list");
>
>   	close(fd);
> @@ -1052,9 +1060,10 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
>   	if (!err)
>   		printf("%s: Success, deleted nsid:%d\n", cmd->name,
>   								cfg.namespace_id);
> -	else if (err > 0)
> +	else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("delete namespace");
>
>    close_fd:
> @@ -1117,9 +1126,10 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
>
>   	if (!err)
>   		printf("%s: Success, nsid:%d\n", cmd->name, cfg.namespace_id);
> -	else if (err > 0)
> +	else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror(attach ? "attach namespace" : "detach namespace");
>
>    close_fd:
> @@ -1216,6 +1226,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
>   			else {
>   				fprintf(stderr, "identify failed\n");
>   				show_nvme_status(err);
> +				err = nvme_status_to_errno(err, false);
>   			}
>   			return err;
>   		}
> @@ -1241,9 +1252,10 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
>   			     cfg.nmic, cfg.timeout, &nsid);
>   	if (!err)
>   		printf("%s: Success, created nsid:%d\n", cmd->name, nsid);
> -	else if (err > 0)
> +	else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("create namespace");
>
>   	close(fd);
> @@ -1840,6 +1852,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
>   		else if (ret > 0) {
>   			fprintf(stderr, "identify failed\n");
>   			show_nvme_status(ret);
> +			ret = nvme_status_to_errno(ret, false);
>   		}
>   		else {
>   			fprintf(stderr, "%s: failed to obtain nvme info: %s\n",
> @@ -1927,10 +1940,10 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
>   			printf("NVME Identify Controller:\n");
>   			__show_nvme_id_ctrl(&ctrl, flags, vs);
>   		}
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("identify controller");
>
>    close_fd:
> @@ -2006,10 +2019,10 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
>   			printf("NVME Namespace Identification Descriptors NS %d:\n", cfg.namespace_id);
>   			show_nvme_id_ns_descs(nsdescs);
>   		}
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("identify namespace");
>
>   	free(nsdescs);
> @@ -2095,10 +2108,10 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
>   			printf("NVME Identify Namespace %d:\n", cfg.namespace_id);
>   			show_nvme_id_ns(&ns, flags);
>   		}
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("identify namespace");
>
>    close_fd:
> @@ -2153,10 +2166,10 @@ static int id_nvmset(int argc, char **argv, struct command *cmd, struct plugin *
>   			printf("NVME Identify NVM Set List %d:\n", cfg.nvmset_id);
>   			show_nvme_id_nvmset(&nvmset);
>   		}
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		perror("identify nvm set list");
>
>    close_fd:
> @@ -2247,6 +2260,7 @@ static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugi
>   	}
>   	else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
>   	} else
>   		perror("virt-mgmt");
>
> @@ -2374,6 +2388,7 @@ static int device_self_test(int argc, char **argv, struct command *cmd, struct p
>   			printf("Device self-test started\n");
>   	} else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
>   	} else
>   		perror("Device self-test");
>
> @@ -2427,6 +2442,7 @@ static int self_test_log(int argc, char **argv, struct command *cmd, struct plug
>   		}
>   	} else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
>   	} else {
>   		perror("self_test_log");
>   	}
> @@ -2556,6 +2572,7 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
>   			d_raw(buf, cfg.data_len);
>   	} else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
>   	} else
>   		perror("get-feature");
>
> @@ -2654,6 +2671,7 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
>   			break;
>   		} else if (err != 0) {
>   			show_nvme_status(err);
> +			err = nvme_status_to_errno(err, false);
>   			break;
>   		}
>   		fw_buf     += cfg.xfer;
> @@ -2750,6 +2768,7 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
>   			break;
>   		default:
>   			show_nvme_status(err);
> +			err = nvme_status_to_errno(err, false);
>   			break;
>   		}
>   	else {
> @@ -2925,8 +2944,10 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
>   			    cfg.no_dealloc, cfg.ovrpat);
>   	if (ret < 0)
>   		perror("sanitize");
> -	else if (ret > 0)
> +	else if (ret > 0) {
>   		show_nvme_status(ret);
> +		ret = nvme_status_to_errno(ret, false);
> +	}
>
>    close_fd:
>   	close(fd);
> @@ -3051,6 +3072,7 @@ static int get_property(int argc, char **argv, struct command *cmd, struct plugi
>   		show_single_property(cfg.offset, value, cfg.human_readable);
>   	} else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
>   	}
>
>    close_fd:
> @@ -3106,6 +3128,7 @@ static int set_property(int argc, char **argv, struct command *cmd, struct plugi
>   				nvme_register_to_string(cfg.offset), cfg.value);
>   	} else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
>   	}
>
>    close_fd:
> @@ -3201,6 +3224,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
>   			else {
>   				fprintf(stderr, "identify failed\n");
>   				show_nvme_status(err);
> +				err = nvme_status_to_errno(err, false);
>   			}
>   			return err;
>   		}
> @@ -3257,9 +3281,10 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
>   				cfg.pil, cfg.ms, cfg.timeout);
>   	if (err < 0)
>   		perror("format");
> -	else if (err != 0)
> +	else if (err != 0) {
>   		show_nvme_status(err);
> -	else {
> +		err = nvme_status_to_errno(err, false);
> +	} else {
>   		printf("Success formatting namespace:%x\n", cfg.namespace_id);
>   		ioctl(fd, BLKRRPART);
>   		if (cfg.reset && S_ISCHR(nvme_stat.st_mode))
> @@ -3378,8 +3403,10 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
>   			else
>   				d(buf, cfg.data_len, 16, 1);
>   		}
> -	} else if (err > 0)
> +	} else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
> +	}
>
>    close_ffd:
>   	close(ffd);
> @@ -3625,8 +3652,10 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
>   				d_raw(buf, cfg.data_len);
>   		}
>   	}
> -	else if (err > 0)
> +	else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
> +	}
>
>   close_ffd:
>   	close(ffd);
> @@ -3682,9 +3711,10 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
>   					cfg.block_count);
>   	if (err < 0)
>   		perror("write uncorrectable");
> -	else if (err != 0)
> +	else if (err != 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		printf("NVME Write Uncorrectable Success\n");
>
>   close_fd:
> @@ -3774,9 +3804,10 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
>   			control, cfg.ref_tag, cfg.app_tag, cfg.app_tag_mask);
>   	if (err < 0)
>   		perror("write-zeroes");
> -	else if (err != 0)
> +	else if (err != 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		printf("NVME Write Zeroes Success\n");
>
>    close_fd:
> @@ -3874,9 +3905,10 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
>   	err = nvme_dsm(fd, cfg.namespace_id, cfg.cdw11, dsm, nr);
>   	if (err < 0)
>   		perror("data-set management");
> -	else if (err != 0)
> +	else if (err != 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		printf("NVMe DSM: success\n");
>
>    close_fd:
> @@ -3922,9 +3954,10 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
>   	err = nvme_flush(fd, cfg.namespace_id);
>   	if (err < 0)
>   		perror("flush");
> -	else if (err != 0)
> +	else if (err != 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		printf("NVMe Flush: success\n");
>   close_fd:
>   	close(fd);
> @@ -3995,9 +4028,10 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
>   				!!cfg.iekey, cfg.crkey, cfg.prkey);
>   	if (err < 0)
>   		perror("reservation acquire");
> -	else if (err != 0)
> +	else if (err != 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		printf("NVME Reservation Acquire success\n");
>
>    close_fd:
> @@ -4072,9 +4106,10 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
>   				!!cfg.iekey, cfg.crkey, cfg.nrkey);
>   	if (err < 0)
>   		perror("reservation register");
> -	else if (err != 0)
> +	else if (err != 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		printf("NVME Reservation  success\n");
>
>    close_fd:
> @@ -4145,9 +4180,10 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
>   				!!cfg.iekey, cfg.crkey);
>   	if (err < 0)
>   		perror("reservation release");
> -	else if (err != 0)
> +	else if (err != 0) {
>   		show_nvme_status(err);
> -	else
> +		err = nvme_status_to_errno(err, false);
> +	} else
>   		printf("NVME Reservation Release success\n");
>
>    close_fd:
> @@ -4463,9 +4499,10 @@ static int submit_io(int opcode, char *command, const char *desc,
>   			command, elapsed_utime(start_time, end_time));
>   	if (err < 0)
>   		perror("submit-io");
> -	else if (err)
> +	else if (err) {
>   		show_nvme_status(err);
> -	else {
> +		err = nvme_status_to_errno(err, false);
> +	} else {
>   		if (!(opcode & 1) && write(dfd, (void *)buffer, cfg.data_size) < 0) {
>   			fprintf(stderr, "write: %s: failed to write buffer to output file\n",
>   					strerror(errno));
> @@ -4720,8 +4757,10 @@ static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin
>   			}
>   		}
>   	}
> -	else if (err > 0)
> +	else if (err > 0) {
>   		show_nvme_status(err);
> +		err = nvme_status_to_errno(err, false);
> +	}
>   free:
>   	if (cfg.data_len)
>   		free(buf);
> @@ -4904,9 +4943,10 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
>   				cfg.timeout, &result);
>   	if (err < 0)
>   		perror("passthru");
> -	else if (err)
> +	else if (err) {
>   		show_nvme_status(err);
> -	else  {
> +		err = nvme_status_to_errno(err, false);
> +	} else  {
>   		if (!cfg.raw_binary) {
>   			fprintf(stderr, "NVMe command result:%08x\n", result);
>   			if (data && cfg.read && !err)
>
