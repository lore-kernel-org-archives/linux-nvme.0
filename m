From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Dec 2016 11:48:19 +0800
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
Message-ID: <201612201158.HoaikVFt%fengguang.wu@intel.com>

Hi Scott,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9 next-20161219]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Scott-Bauer/include-Add-definitions-for-sed/20161220-110214
config: i386-randconfig-r0-201651 (attached as .config)
compiler: gcc-5 (Debian 5.4.1-2) 5.4.1 20160904
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from lib/sed.c:20:0:
>> include/linux/sed-opal.h:37:40: warning: 'struct request_queue' declared inside parameter list
    struct opal_dev *alloc_opal_dev(struct request_queue *q);
                                           ^
>> include/linux/sed-opal.h:37:40: warning: its scope is only this definition or declaration, which is probably not what you want
   lib/sed.c: In function 'fdev_sed_ioctl':
   lib/sed.c:161:12: error: dereferencing pointer to incomplete type 'struct file'
     if (!filep->f_sedctx || !filep->f_sedctx->ops || !filep->f_sedctx->dev)
               ^
--
   In file included from lib/sed-opal.c:29:0:
>> include/linux/sed-opal.h:37:40: warning: 'struct request_queue' declared inside parameter list
    struct opal_dev *alloc_opal_dev(struct request_queue *q);
                                           ^
>> include/linux/sed-opal.h:37:40: warning: its scope is only this definition or declaration, which is probably not what you want
   lib/sed-opal.c: In function 'opal_discovery0_end':
   lib/sed-opal.c:276:6: warning: unused variable 'error' [-Wunused-variable]
     int error = 0;
         ^
   lib/sed-opal.c: In function 'response_parse':
   lib/sed-opal.c:793:15: error: invalid storage class for function 'response_get_string'
    static size_t response_get_string(const struct parsed_resp *resp, int n,
                  ^
   lib/sed-opal.c:793:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static size_t response_get_string(const struct parsed_resp *resp, int n,
    ^
   lib/sed-opal.c:817:12: error: invalid storage class for function 'response_get_u64'
    static u64 response_get_u64(const struct parsed_resp *resp, int n)
               ^
   lib/sed-opal.c:846:11: error: invalid storage class for function 'response_status'
    static u8 response_status(const struct parsed_resp *resp)
              ^
   lib/sed-opal.c:866:12: error: invalid storage class for function 'parse_and_check_status'
    static int parse_and_check_status(struct opal_dev *dev)
               ^
   lib/sed-opal.c:883:13: error: invalid storage class for function 'clear_opal_cmd'
    static void clear_opal_cmd(struct opal_cmd *cmd)
                ^
   lib/sed-opal.c:891:12: error: invalid storage class for function 'start_opal_session_cont'
    static int start_opal_session_cont(struct opal_dev *dev)
               ^
   lib/sed-opal.c:913:20: error: invalid storage class for function 'opal_dev_get'
    static inline void opal_dev_get(struct opal_dev *dev)
                       ^
   lib/sed-opal.c:918:20: error: invalid storage class for function 'opal_dev_put'
    static inline void opal_dev_put(struct opal_dev *dev)
                       ^
   lib/sed-opal.c:923:12: error: invalid storage class for function 'add_suspend_info'
    static int add_suspend_info(struct opal_dev *dev, struct opal_suspend_data *sus)
               ^
   lib/sed-opal.c:949:12: error: invalid storage class for function 'end_session_cont'
    static int end_session_cont(struct opal_dev *dev)
               ^
   lib/sed-opal.c:956:12: error: invalid storage class for function 'finalize_and_send'
    static int finalize_and_send(struct opal_dev *dev, struct opal_cmd *cmd,
               ^
   lib/sed-opal.c:972:12: error: invalid storage class for function 'gen_key'
    static int gen_key(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1002:12: error: invalid storage class for function 'get_active_key_cont'
    static int get_active_key_cont(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1027:12: error: invalid storage class for function 'get_active_key'
    static int get_active_key(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1067:12: error: invalid storage class for function 'generic_lr_enable_disable'
    static int generic_lr_enable_disable(struct opal_cmd *cmd,
               ^
   lib/sed-opal.c:1107:19: error: invalid storage class for function 'enable_global_lr'
    static inline int enable_global_lr(struct opal_cmd *cmd, u8 *uid,
                      ^
   lib/sed-opal.c:1118:12: error: invalid storage class for function 'setup_locking_range'
    static int setup_locking_range(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1183:12: error: invalid storage class for function 'start_generic_opal_session'
    static int start_generic_opal_session(struct opal_dev *dev,
               ^
   lib/sed-opal.c:1242:12: error: invalid storage class for function 'start_anybodyASP_opal_session'
    static int start_anybodyASP_opal_session(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1248:12: error: invalid storage class for function 'start_SIDASP_opal_session'
    static int start_SIDASP_opal_session(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1271:19: error: invalid storage class for function 'start_admin1LSP_opal_session'
    static inline int start_admin1LSP_opal_session(struct opal_dev *dev)
                      ^
   lib/sed-opal.c:1279:12: error: invalid storage class for function 'start_auth_opal_session'
    static int start_auth_opal_session(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1332:12: error: invalid storage class for function 'revert_tper'
    static int revert_tper(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1354:12: error: invalid storage class for function 'internal_activate_user'
    static int internal_activate_user(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1391:12: error: invalid storage class for function 'erase_locking_range'
    static int erase_locking_range(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1419:12: error: invalid storage class for function 'set_mbr_done'
    static int set_mbr_done(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1451:12: error: invalid storage class for function 'set_mbr_enable_disable'
    static int set_mbr_enable_disable(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1483:12: error: invalid storage class for function 'generic_pw_cmd'
    static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
               ^
   lib/sed-opal.c:1510:12: error: invalid storage class for function 'set_new_pw'
    static int set_new_pw(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1536:12: error: invalid storage class for function 'set_sid_cpin_pin'
    static int set_sid_cpin_pin(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1551:12: error: invalid storage class for function 'add_user_to_lr'
    static int add_user_to_lr(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1621:12: error: invalid storage class for function 'lock_unlock_locking_range'
    static int lock_unlock_locking_range(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1687:12: error: invalid storage class for function 'lock_unlock_locking_range_SUM'
    static int lock_unlock_locking_range_SUM(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1782:12: error: invalid storage class for function 'get_lsp_lifecycle_cont'
    static int get_lsp_lifecycle_cont(struct opal_dev *dev)
               ^
   lib/sed-opal.c: In function 'get_lsp_lifecycle_cont':
   lib/sed-opal.c:1799:1: warning: label 'err_return' defined but not used [-Wunused-label]
    err_return:
    ^
   lib/sed-opal.c: In function 'response_parse':
   lib/sed-opal.c:1842:12: error: invalid storage class for function 'get_msid_cpin_pin_cont'
    static int get_msid_cpin_pin_cont(struct opal_dev *dev)
               ^
   lib/sed-opal.c: In function 'get_msid_cpin_pin_cont':
   lib/sed-opal.c:1864:2: warning: label 'err_return' defined but not used [-Wunused-label]
     err_return:
     ^
   lib/sed-opal.c: In function 'response_parse':
   lib/sed-opal.c:1868:12: error: invalid storage class for function 'get_msid_cpin_pin'
    static int get_msid_cpin_pin(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1906:12: error: invalid storage class for function 'build_end_opal_session'
    static int build_end_opal_session(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1917:12: error: invalid storage class for function 'end_opal_session'
    static int end_opal_session(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1931:12: error: invalid storage class for function 'end_opal_session_error'
    static int end_opal_session_error(struct opal_dev *dev)
               ^
>> lib/sed-opal.c:1939:40: warning: 'struct request_queue' declared inside parameter list
    struct opal_dev *alloc_opal_dev(struct request_queue *q)
                                           ^
   lib/sed-opal.c: In function 'alloc_opal_dev':
   lib/sed-opal.c:1953:15: error: implicit declaration of function 'queue_dma_alignment' [-Werror=implicit-function-declaration]
     dma_align = (queue_dma_alignment(q) | q->dma_pad_mask) + 1;
                  ^
   lib/sed-opal.c:1953:41: error: dereferencing pointer to incomplete type 'struct request_queue'
     dma_align = (queue_dma_alignment(q) | q->dma_pad_mask) + 1;
                                            ^
   lib/sed-opal.c: In function 'response_parse':
   lib/sed-opal.c:1968:12: error: invalid storage class for function 'do_cmds'
    static int do_cmds(struct opal_dev *dev)
               ^
   lib/sed-opal.c:1968:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static int do_cmds(struct opal_dev *dev)
    ^
   lib/sed-opal.c:1976:25: error: invalid storage class for function 'get_opal_dev'
    static struct opal_dev *get_opal_dev(struct sed_context *sedc,
                            ^
   lib/sed-opal.c:2019:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_erase_locking_range(struct sed_context *sedc, struct sed_key *key)
    ^
   lib/sed-opal.c:2043:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_enable_disable_shadow_mbr(struct sed_context *sedc,
    ^
   lib/sed-opal.c:2077:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_save(struct sed_context *sedc, struct sed_key *key)
    ^
   lib/sed-opal.c:2098:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_add_user_to_lr(struct sed_context *sedc, struct sed_key *key)
    ^
   lib/sed-opal.c:2139:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_reverttper(struct sed_context *sedc, struct sed_key *key)
    ^
   lib/sed-opal.c:2162:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    const opal_step ulk_funcs_SUM[] = {
    ^
   lib/sed-opal.c:2202:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_take_ownership(struct sed_context *sedc, struct sed_key *key)
    ^
   lib/sed-opal.c:2227:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_activate_lsp(struct sed_context *sedc, struct sed_key *key)
    ^
   lib/sed-opal.c:2250:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_setup_locking_range(struct sed_context *sedc, struct sed_key *pw)
    ^
   lib/sed-opal.c:2273:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_set_new_pw(struct sed_context *sedc, struct sed_key *pw)
    ^
   lib/sed-opal.c:2306:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_activate_user(struct sed_context *sedc, struct sed_key *pw)
    ^
   lib/sed-opal.c:2342:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int opal_unlock_from_suspend(struct sed_context *sedc)
    ^
   lib/sed-opal.c:2376:1: error: expected declaration or statement at end of input
    EXPORT_SYMBOL(opal_unlock_from_suspend);
    ^
   lib/sed-opal.c:727:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret, num_entries = 0;
         ^
   cc1: some warnings being treated as errors

vim +37 include/linux/sed-opal.h

0d963c73 Scott Bauer 2016-12-19  21  #include <linux/sed.h>
0d963c73 Scott Bauer 2016-12-19  22  #include <linux/kernel.h>
0d963c73 Scott Bauer 2016-12-19  23  
0d963c73 Scott Bauer 2016-12-19  24  int opal_save(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  25  int opal_lock_unlock(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  26  int opal_take_ownership(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  27  int opal_activate_lsp(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  28  int opal_set_new_pw(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  29  int opal_activate_user(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  30  int opal_reverttper(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  31  int opal_setup_locking_range(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  32  int opal_add_user_to_lr(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  33  int opal_enable_disable_shadow_mbr(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  34  int opal_erase_locking_range(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  35  int opal_secure_erase_locking_range(struct sed_context *sedc, struct sed_key *key);
0d963c73 Scott Bauer 2016-12-19  36  int opal_unlock_from_suspend(struct sed_context *sedc);
0d963c73 Scott Bauer 2016-12-19 @37  struct opal_dev *alloc_opal_dev(struct request_queue *q);
0d963c73 Scott Bauer 2016-12-19  38  #endif /* LINUX_OPAL_H */

:::::: The code at line 37 was first introduced by commit
:::::: 0d963c733cceca032531cf3f500125bc28d01178 include: Add definitions for sed

:::::: TO: Scott Bauer <scott.bauer at intel.com>
:::::: CC: 0day robot <fengguang.wu at intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22850 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161220/b5427c66/attachment-0001.gz>
