From: yangds.fnst@cn.fujitsu.com (Dongsheng Yang)
Date: Fri, 4 Sep 2015 16:27:11 +0800
Subject: [PATCH v7 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <55E950BA.50203@bjorling.me>
References: <1438957791-24632-1-git-send-email-mb@lightnvm.io>
 <1438957791-24632-2-git-send-email-mb@lightnvm.io>
 <55E67218.9010701@cn.fujitsu.com> <55E6D41A.5060100@bjorling.me>
 <55E94301.3010501@cn.fujitsu.com> <55E950BA.50203@bjorling.me>
Message-ID: <55E955DF.5020303@cn.fujitsu.com>

On 09/04/2015 04:05 PM, Matias Bj?rling wrote:
>>
>> So here is a suggestion, register_bm again
>> if we found nvm_dev->bm == NULL in create_target(). And if it is still
>> NULL after that. return an error "nvm: no compatible bm was found"
>> and stop target creating. Otherwise, there would be a NULL Pointer
>> reference problem.
>>
>> That's a real problem I met in my testing and I did this change
>> in my local using. I hope that's useful to you.
>>
> Hi Yang,
> ac
> Similar to this?

Okey, I attached two changes in my local using. I hope that
useful to you.

Yang
>
> diff --git i/drivers/lightnvm/core.c w/drivers/lightnvm/core.c
> index 5e4c2b8..0d2e5e3 100644
> --- i/drivers/lightnvm/core.c
> +++ w/drivers/lightnvm/core.c
> @@ -262,8 +262,9 @@ int nvm_init(struct nvm_dev *dev)
>          }
>
>          if (!ret) {
> -               pr_info("nvm: no compatible bm was found.\n");
> -               return 0;
> +               pr_info("nvm: %s was not initialized due to no
> compatible bm.\n",
> +                                                               dev->name);
> +               return -EINVAL;
>          }
>
>          pr_info("nvm: registered %s with luns: %u blocks: %lu sector
> size: %d\n",
>
>
>
> .
>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-lightNVM-register-bm-in-nvm_create_target-if-dev-bm-.patch
Type: text/x-patch
Size: 1558 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150904/62365bf4/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-lightNVM-fix-a-compatibility-problem-in-compiling.patch
Type: text/x-patch
Size: 5428 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150904/62365bf4/attachment-0001.bin>
