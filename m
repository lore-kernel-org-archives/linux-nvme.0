From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Dec 2016 11:21:49 +0800
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
Message-ID: <201612201151.7jQHOkJQ%fengguang.wu@intel.com>

Hi Scott,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9 next-20161219]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Scott-Bauer/include-Add-definitions-for-sed/20161220-110214
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from lib/sed.c:20:0:
>> include/linux/sed-opal.h:37:40: warning: 'struct request_queue' declared inside parameter list will not be visible outside of this definition or declaration
    struct opal_dev *alloc_opal_dev(struct request_queue *q);
                                           ^~~~~~~~~~~~~
   lib/sed.c: In function 'fdev_sed_ioctl':
>> lib/sed.c:161:12: error: dereferencing pointer to incomplete type 'struct file'
     if (!filep->f_sedctx || !filep->f_sedctx->ops || !filep->f_sedctx->dev)
               ^~
--
   In file included from lib/sed-opal.c:29:0:
>> include/linux/sed-opal.h:37:40: warning: 'struct request_queue' declared inside parameter list will not be visible outside of this definition or declaration
    struct opal_dev *alloc_opal_dev(struct request_queue *q);
                                           ^~~~~~~~~~~~~
   lib/sed-opal.c: In function 'opal_discovery0_end':
   lib/sed-opal.c:276:6: warning: unused variable 'error' [-Wunused-variable]
     int error = 0;
         ^~~~~
   lib/sed-opal.c: In function 'response_parse':
>> lib/sed-opal.c:793:15: error: invalid storage class for function 'response_get_string'
    static size_t response_get_string(const struct parsed_resp *resp, int n,
                  ^~~~~~~~~~~~~~~~~~~
>> lib/sed-opal.c:793:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static size_t response_get_string(const struct parsed_resp *resp, int n,
    ^~~~~~
>> lib/sed-opal.c:817:12: error: invalid storage class for function 'response_get_u64'
    static u64 response_get_u64(const struct parsed_resp *resp, int n)
               ^~~~~~~~~~~~~~~~
>> lib/sed-opal.c:846:11: error: invalid storage class for function 'response_status'
    static u8 response_status(const struct parsed_resp *resp)
              ^~~~~~~~~~~~~~~
>> lib/sed-opal.c:866:12: error: invalid storage class for function 'parse_and_check_status'
    static int parse_and_check_status(struct opal_dev *dev)
               ^~~~~~~~~~~~~~~~~~~~~~
>> lib/sed-opal.c:883:13: error: invalid storage class for function 'clear_opal_cmd'
    static void clear_opal_cmd(struct opal_cmd *cmd)
                ^~~~~~~~~~~~~~
>> lib/sed-opal.c:891:12: error: invalid storage class for function 'start_opal_session_cont'
    static int start_opal_session_cont(struct opal_dev *dev)
               ^~~~~~~~~~~~~~~~~~~~~~~
>> lib/sed-opal.c:913:20: error: invalid storage class for function 'opal_dev_get'
    static inline void opal_dev_get(struct opal_dev *dev)
                       ^~~~~~~~~~~~
>> lib/sed-opal.c:918:20: error: invalid storage class for function 'opal_dev_put'
    static inline void opal_dev_put(struct opal_dev *dev)
                       ^~~~~~~~~~~~
>> lib/sed-opal.c:923:12: error: invalid storage class for function 'add_suspend_info'
    static int add_suspend_info(struct opal_dev *dev, struct opal_suspend_data *sus)
               ^~~~~~~~~~~~~~~~
>> lib/sed-opal.c:949:12: error: invalid storage class for function 'end_session_cont'
    static int end_session_cont(struct opal_dev *dev)
               ^~~~~~~~~~~~~~~~
>> lib/sed-opal.c:956:12: error: invalid storage class for function 'finalize_and_send'
    static int finalize_and_send(struct opal_dev *dev, struct opal_cmd *cmd,
               ^~~~~~~~~~~~~~~~~
>> lib/sed-opal.c:972:12: error: invalid storage class for function 'gen_key'
    static int gen_key(struct opal_dev *dev)
               ^~~~~~~
>> lib/sed-opal.c:1002:12: error: invalid storage class for function 'get_active_key_cont'
    static int get_active_key_cont(struct opal_dev *dev)
               ^~~~~~~~~~~~~~~~~~~
>> lib/sed-opal.c:1027:12: error: invalid storage class for function 'get_active_key'
    static int get_active_key(struct opal_dev *dev)
               ^~~~~~~~~~~~~~
>> lib/sed-opal.c:1067:12: error: invalid storage class for function 'generic_lr_enable_disable'
    static int generic_lr_enable_disable(struct opal_cmd *cmd,
               ^~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/sed-opal.c:1107:19: error: invalid storage class for function 'enable_global_lr'
    static inline int enable_global_lr(struct opal_cmd *cmd, u8 *uid,
                      ^~~~~~~~~~~~~~~~
>> lib/sed-opal.c:1118:12: error: invalid storage class for function 'setup_locking_range'
    static int setup_locking_range(struct opal_dev *dev)
               ^~~~~~~~~~~~~~~~~~~
>> lib/sed-opal.c:1183:12: error: invalid storage class for function 'start_generic_opal_session'
    static int start_generic_opal_session(struct opal_dev *dev,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~

vim +161 lib/sed.c

    14	 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
    15	 * more details.
    16	 */
    17	
    18	#include <linux/blkdev.h>
    19	#include <linux/sed.h>
  > 20	#include <linux/sed-opal.h>
    21	#include <asm/uaccess.h>
    22	
    23	int sed_save(struct sed_context *sed_ctx, struct sed_key *key)
    24	{
    25		switch (key->sed_type) {
    26		case OPAL_LOCK_UNLOCK:
    27			return opal_save(sed_ctx, key);
    28		}
    29	
    30		return -EOPNOTSUPP;
    31	}
    32	
    33	int sed_lock_unlock(struct sed_context *sed_ctx, struct sed_key *key)
    34	{
    35		switch (key->sed_type) {
    36		case OPAL_LOCK_UNLOCK:
    37			return opal_lock_unlock(sed_ctx, key);
    38		}
    39	
    40		return -EOPNOTSUPP;
    41	}
    42	
    43	int sed_take_ownership(struct sed_context *sed_ctx, struct sed_key *key)
    44	{
    45	
    46		switch (key->sed_type) {
    47		case OPAL:
    48			return opal_take_ownership(sed_ctx, key);
    49		}
    50	
    51		return -EOPNOTSUPP;
    52	}
    53	
    54	int sed_activate_lsp(struct sed_context *sed_ctx, struct sed_key *key)
    55	{
    56	
    57		switch (key->sed_type) {
    58		case OPAL:
    59			return opal_activate_lsp(sed_ctx, key);
    60		}
    61	
    62		return -EOPNOTSUPP;
    63	}
    64	
    65	int sed_set_pw(struct sed_context *sed_ctx, struct sed_key *key)
    66	{
    67	
    68		switch (key->sed_type) {
    69		case OPAL_PW:
    70			return opal_set_new_pw(sed_ctx, key);
    71		}
    72	
    73		return -EOPNOTSUPP;
    74	}
    75	
    76	int sed_activate_user(struct sed_context *sed_ctx, struct sed_key *key)
    77	{
    78	
    79		switch (key->sed_type) {
    80		case OPAL_ACT_USR:
    81			return opal_activate_user(sed_ctx, key);
    82		}
    83	
    84		return -EOPNOTSUPP;
    85	}
    86	
    87	int sed_reverttper(struct sed_context *sed_ctx, struct sed_key *key)
    88	{
    89	
    90		switch (key->sed_type) {
    91		case OPAL:
    92			return opal_reverttper(sed_ctx, key);
    93		}
    94	
    95		return -EOPNOTSUPP;
    96	}
    97	
    98	int sed_setup_locking_range(struct sed_context *sed_ctx, struct sed_key *key)
    99	{
   100	
   101		switch (key->sed_type) {
   102		case OPAL_LR_SETUP:
   103			return opal_setup_locking_range(sed_ctx, key);
   104		}
   105	
   106		return -EOPNOTSUPP;
   107	}
   108	
   109	int sed_adduser_to_lr(struct sed_context *sed_ctx, struct sed_key *key)
   110	{
   111	
   112		switch (key->sed_type) {
   113		case OPAL_LOCK_UNLOCK:
   114			return opal_add_user_to_lr(sed_ctx, key);
   115		}
   116	
   117		return -EOPNOTSUPP;
   118	}
   119	
   120	int sed_do_mbr(struct sed_context *sed_ctx, struct sed_key *key)
   121	{
   122	
   123		switch (key->sed_type) {
   124		case OPAL_MBR_DATA:
   125			return opal_enable_disable_shadow_mbr(sed_ctx, key);
   126		}
   127	
   128		return -EOPNOTSUPP;
   129	}
   130	
   131	int sed_erase_lr(struct sed_context *sed_ctx, struct sed_key *key)
   132	{
   133	
   134		switch (key->sed_type) {
   135		case OPAL:
   136			return opal_erase_locking_range(sed_ctx, key);
   137		}
   138	
   139		return -EOPNOTSUPP;
   140	}
   141	
   142	int sed_secure_erase_lr(struct sed_context *sed_ctx, struct sed_key *key)
   143	{
   144		switch (key->sed_type) {
   145		case OPAL_ACT_USR:
   146			return opal_secure_erase_locking_range(sed_ctx, key);
   147	
   148		}
   149		return -EOPNOTSUPP;
   150	}
   151	
   152	int fdev_sed_ioctl(struct file *filep, unsigned int cmd,
   153			   unsigned long arg)
   154	{
   155		struct sed_key key;
   156		struct sed_context *sed_ctx;
   157	
   158		if (!capable(CAP_SYS_ADMIN))
   159			return -EACCES;
   160	
 > 161		if (!filep->f_sedctx || !filep->f_sedctx->ops || !filep->f_sedctx->dev)
   162			return -ENODEV;
   163	
   164		sed_ctx = filep->f_sedctx;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6384 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161220/35b81b36/attachment-0001.gz>
