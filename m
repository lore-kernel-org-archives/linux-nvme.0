From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Feb 2019 13:25:42 -0800
Subject: [PATCH 3/3 rfc] nvme: fire discovery log page change events to
 userspace
In-Reply-To: <d65021ac-b9ef-fa99-0a89-379f4583c646@suse.de>
References: <20190223023117.20517-1-sagi@grimberg.me>
 <20190223023117.20517-4-sagi@grimberg.me>
 <d65021ac-b9ef-fa99-0a89-379f4583c646@suse.de>
Message-ID: <5be61dd6-deb1-d642-eebc-d0942f061d34@grimberg.me>


>> @@ -3527,6 +3528,28 @@ static void nvme_aen_uevent(struct nvme_ctrl 
>> *ctrl)
>> ????? kfree(envp[0]);
>> ? }
>> +static void nvme_disc_aen_uevent(struct nvme_ctrl *ctrl)
>> +{
>> +??? struct nvmf_ctrl_options *opts = ctrl->opts;
>> +??? char *envp[16];
>> +??? int i, envloc = 0;
>> +
>> +??? envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_EVENT=discovery");
>> +??? envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_INSTANCE=%d", 
>> ctrl->instance);
>> +??? envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRTYPE=%s", 
>> opts->transport);
>> +??? envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRADDR=%s", 
>> opts->traddr);
>> +??? envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRSVCID=%s", 
>> opts->trsvcid);
>> +??? envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_HOST_TRADDR=%s",
>> +??????????? opts->host_traddr ?: "none");
>> +??? envp[envloc] = NULL;
>> +
> trsvcid is also optional, so we should be using
> 
> opts->trsvcid ?: "none"
> 
> here, too.


Yea, you're right
