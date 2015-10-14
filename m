From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 04:52:17 +0800
Subject: [PATCH v10 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <1444850524-16827-2-git-send-email-m@bjorling.me>
Message-ID: <201510150404.YgKu7QhT%fengguang.wu@intel.com>

Hi Matias,

[auto build test WARNING on block/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matias-Bj-rling/Support-for-Open-Channel-SSDs/20151014-224617
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/lightnvm/core.c:37:21: sparse: symbol 'nvm_find_target_type' was not declared. Should it be static?
>> drivers/lightnvm/core.c:126:16: sparse: symbol 'nvm_find_nvm_dev' was not declared. Should it be static?
>> drivers/lightnvm/core.c:212:5: sparse: symbol 'nvm_validate_features' was not declared. Should it be static?
>> drivers/lightnvm/core.c:226:5: sparse: symbol 'nvm_validate_responsibility' was not declared. Should it be static?
>> drivers/lightnvm/core.c:234:5: sparse: symbol 'nvm_init' was not declared. Should it be static?
>> drivers/lightnvm/core.c:307:6: sparse: symbol 'nvm_exit' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
