From: james.smart@broadcom.com (James Smart)
Date: Mon, 30 Apr 2018 09:45:36 -0700
Subject: [PATCH] nvme-cli: Add ioctl retry support for connect-all
In-Reply-To: <20180427213942.GC5073@localhost.localdomain>
References: <20180427172901.3479-1-jsmart2021@gmail.com>
 <20180427213942.GC5073@localhost.localdomain>
Message-ID: <b8d9a47f-1aaa-524e-a7dd-f8003403e21b@broadcom.com>

OK. I still believe we'll keep adding it in, but I'm good with a reduced 
patch.

-- james


On 4/27/2018 2:39 PM, Keith Busch wrote:
> On Fri, Apr 27, 2018@10:29:01AM -0700, James Smart wrote:
>>   /* Generic passthrough */
>> -int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd);
>> +int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd,
>> +		int maxretry);
> Hi James,
>
> Since the far majority of the callers don't care for retries, let's
> leave this API alone and create a new one that takes the retries. The
> old API can call the new one with the default value of NO_RETRIES, and
> that should simplify this patch significantly.
>
> Thanks,
> Keith
