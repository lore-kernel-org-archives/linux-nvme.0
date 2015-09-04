From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Fri, 04 Sep 2015 10:05:14 +0200
Subject: [PATCH v7 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <55E94301.3010501@cn.fujitsu.com>
References: <1438957791-24632-1-git-send-email-mb@lightnvm.io>
 <1438957791-24632-2-git-send-email-mb@lightnvm.io>
 <55E67218.9010701@cn.fujitsu.com> <55E6D41A.5060100@bjorling.me>
 <55E94301.3010501@cn.fujitsu.com>
Message-ID: <55E950BA.50203@bjorling.me>

>
> So here is a suggestion, register_bm again
> if we found nvm_dev->bm == NULL in create_target(). And if it is still
> NULL after that. return an error "nvm: no compatible bm was found"
> and stop target creating. Otherwise, there would be a NULL Pointer
> reference problem.
>
> That's a real problem I met in my testing and I did this change
> in my local using. I hope that's useful to you.
>
Hi Yang,

Similar to this?

diff --git i/drivers/lightnvm/core.c w/drivers/lightnvm/core.c
index 5e4c2b8..0d2e5e3 100644
--- i/drivers/lightnvm/core.c
+++ w/drivers/lightnvm/core.c
@@ -262,8 +262,9 @@ int nvm_init(struct nvm_dev *dev)
         }

         if (!ret) {
-               pr_info("nvm: no compatible bm was found.\n");
-               return 0;
+               pr_info("nvm: %s was not initialized due to no 
compatible bm.\n",
+                                                               dev->name);
+               return -EINVAL;
         }

         pr_info("nvm: registered %s with luns: %u blocks: %lu sector 
size: %d\n",
