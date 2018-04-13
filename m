From: javier@cnexlabs.com (Javier Gonzalez)
Date: Fri, 13 Apr 2018 17:20:02 +0000
Subject: [PATCH] nvme: allow lightnvm to have visibility over AER events
In-Reply-To: <20180413171123.GA7732@infradead.org>
References: <1523619780-10882-1-git-send-email-javier@cnexlabs.com>
 <1523619780-10882-2-git-send-email-javier@cnexlabs.com>,
 <20180413171123.GA7732@infradead.org>
Message-ID: <48F7E40C-0C23-4EF4-A50F-B0E720CB168D@cnexlabs.com>


> On 13 Apr 2018,@19.11, Christoph Hellwig <hch@infradead.org> wrote:
> 
> 
>> enum {
>> +    /* valid bit mask */
>> +    NVM_LOGPAGE_STATE_MASK        = 0x3,
>> +    NVM_LOGPAGE_SEVERITY_MASK    = 0x5,
>> +
>> +    /* scope */
>> +    NVM_LOGPAGE_SCOPE_SECTOR    = 1,
>> +    NVM_LOGPAGE_SCOPE_CHUNK        = 2,
>> +    NVM_LOGPAGE_SCOPE_LUN        = 4,
>> +
>> +    /* severity */
>> +    NVM_LOGPAGE_SEVERITY_LOW    = 1,
>> +    NVM_LOGPAGE_SEVERITY_MID    = 2,
>> +    NVM_LOGPAGE_SEVERITY_HIGH    = 4,
>> +    NVM_LOGPAGE_SEVERITY_UNREC    = 8,
>> +    NVM_LOGPAGE_SEVERITY_DEV    = 16,
>> +};
>> +
>> +struct nvm_log_page {
>> +    struct ppa_addr ppa;
>> +    u16 scope;
>> +    u8 severity;
>> +};
>> +
>> +enum {
>>    /* Chunk states */
>>    NVM_CHK_ST_FREE =    1 << 0,
>>    NVM_CHK_ST_CLOSED =    1 << 1,
>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index 4112e2bd747f..f85053601c5b 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -440,6 +440,7 @@ enum {
>>    NVME_AER_VS            = 7,
>>    NVME_AER_NOTICE_NS_CHANGED    = 0x0002,
>>    NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
>> +    NVME_AER_NOTICE_LNVM_CHUNK    = 0xd00007,
>> };
> 
> Non of these is in the NVMe spec or a ratified TP, so NAK.

I only included these to show an example. At this point I only intend to build the foundation, not upstream non-standard,
as you point out. I should have made this more clear in the RFC message. 
