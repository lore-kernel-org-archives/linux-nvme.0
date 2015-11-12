From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Thu, 12 Nov 2015 11:01:10 +0100
Subject: [PATCH v14 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <CAMuHMdVfboMmbWcd_iCJ2KqAAmYjYUZ9_i4yFut6rRwQ75X+eQ@mail.gmail.com>
References: <1446058499-24150-1-git-send-email-m@bjorling.me>	<1446058499-24150-2-git-send-email-m@bjorling.me>
 <CAMuHMdVfboMmbWcd_iCJ2KqAAmYjYUZ9_i4yFut6rRwQ75X+eQ@mail.gmail.com>
Message-ID: <56446366.8050907@bjorling.me>

On 11/11/2015 11:46 PM, Geert Uytterhoeven wrote:
> On Wed, Oct 28, 2015@7:54 PM, Matias Bj?rling <m@bjorling.me> wrote:
>> +struct nvm_dev_ops {
>
> [...]
>
>> +       uint8_t                 max_phys_sect;
>> +};
>
>> --- /dev/null
>> +++ b/drivers/lightnvm/core.c
>
>> +int nvm_register(struct request_queue *q, char *disk_name,
>> +                                                       struct nvm_dev_ops *ops)
>> +{
>
> [...]
>
>> +       } else if (dev->ops->max_phys_sect > 256) {
>
> drivers/nfc/nfcmrvl/i2c.c:52: warning: comparison is always false due
> to limited range of data type
>
> Indeed, max_phys_sect is "uint8_t", so its maximum value is 255.
>
>> +               pr_info("nvm: max sectors supported is 256.\n");
>
> Hence this message is not correct. What's the intended maximum value?
> 255 or 256?

Good catch. It'll be 256, the typically device driver supports 64. The 
256 is just an upper sensible bound. I'll create a patch to make it an 
unsigned short.

Thanks
