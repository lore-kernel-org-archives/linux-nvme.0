From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 00:59:56 +0300
Subject: [PATCH 04/17] IB/isert: use T10-PI check mask definitions from
 core layer
In-Reply-To: <20180530152436.GB30764@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-5-git-send-email-maxg@mellanox.com>
 <20180528072225.GE5618@lst.de>
 <b8fa242d-c2d5-79fe-cab2-1c73adadbc4b@mellanox.com>
 <20180530120801.GA1817@lst.de> <20180530152436.GB30764@mellanox.com>
Message-ID: <32f61c33-e0e0-0487-330a-0ecdad9e633a@grimberg.me>


>>> -       sig_attrs->check_mask =
>>> -              (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD  ? 0xc0 : 0) |
>>> -              (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG ? 0x30 : 0) |
>>> -              (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x0f : 0);
>>> +       if (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD)
>>> +               sig_attrs->check_mask |= IB_SIG_CHECK_GUARD;
>>> +       if (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG)
>>> +               sig_attrs->check_mask |= IB_SIG_CHECK_APPTAG;
>>> +       if (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG)
>>> +               sig_attrs->check_mask |= IB_SIG_CHECK_REFTAG;
>>> +
>>>          return 0;
>>>   }
>>>
>>>
>>>
>>> I can reduce the instructions since we don't need to do a bitwise "or" with
>>> 0 (check mask is set to 0 in the start of the function).
>>
>> And it looks much cleaner to start with..
> 
> I also prefer this version to the use of the ternary operator..

I concur, when you send it out, you can add

Reviewed-by: Sagi Grimberg <sagi at grimbrg.me>
