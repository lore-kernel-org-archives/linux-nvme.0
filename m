From: james.smart@broadcom.com (James Smart)
Date: Tue, 7 Mar 2017 13:37:35 -0800
Subject: [PATCH] lpfc: Finalize Kconfig options for nvme
In-Reply-To: <20170307212351.GA5697@infradead.org>
References: <1488914228-7289-1-git-send-email-jsmart2021@gmail.com>
 <20170307212351.GA5697@infradead.org>
Message-ID: <6ae124f3-b5c7-655a-fda8-cb08ec71dab9@broadcom.com>



On 3/7/2017 1:23 PM, Christoph Hellwig wrote:
>> +#if defined(CONFIG_NVME_FC)
>> +#define CONFIG_LPFC_NVME_INITIATOR
>> +#endif
>> +
>> +#if defined(CONFIG_NVME_TARGET_FC)
>> +#define CONFIG_LPFC_NVME_TARGET
>> +#endif
> The CONFIG_* namespace is reserved for Kconfig defined symbols.
>
> Also I think the above is wrong if the nvme fc core code is built
> modular.  I think you want to replace all occurances of
>
> #ifdef CONFIG_LPFC_NVME_INITIATOR
>
> with
>
> if (IS_ENABLED(CONFIG_NVME_FC))
>
> and vice versa for the taget.

make sense

-- james
