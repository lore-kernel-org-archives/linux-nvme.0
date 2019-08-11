From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 10 Aug 2019 22:14:34 -0700
Subject: [PATCH v5 2/7] nvme: return a proper status for sync commands
 failure
In-Reply-To: <CAOSXXT607=1L5TywNgpi242kcKP-P64Bz4atUgQ6iT=B41HV1A@mail.gmail.com>
References: <20190809221211.21157-1-sagi@grimberg.me>
 <20190809221211.21157-3-sagi@grimberg.me>
 <CAOSXXT607=1L5TywNgpi242kcKP-P64Bz4atUgQ6iT=B41HV1A@mail.gmail.com>
Message-ID: <2321fe18-91e5-dd7d-d231-d64b4dc1afb2@grimberg.me>


>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -805,7 +805,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>>          if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>>                  ret = -EINTR;
>>          else
>> -               ret = nvme_req(req)->status;
>> +               ret = nvme_error_status(req);
>>    out:
>>          blk_mq_free_request(req);
>>          return ret;
>> @@ -896,7 +896,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>>          if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>>                  ret = -EINTR;
>>          else
>> -               ret = nvme_req(req)->status;
>> +               ret = nvme_error_status(req);
>>          if (result)
>>                  *result = le32_to_cpu(nvme_req(req)->result.u32);
>>          if (meta && !ret && !write) {
>> --
> 
> Fine for the driver initiated commands, but no for user commands.
> Tooling definitely wants to see the NVMe status directly, and we'll
> break them all if we change this API.

OK, I can leave that one alone...
