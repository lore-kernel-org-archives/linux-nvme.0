From: james.smart@broadcom.com (James Smart)
Date: Fri, 9 Nov 2018 10:55:56 -0800
Subject: [PATCH] nvme-rdma: Don't fail the controller if only part of the
 queues fail to connect
In-Reply-To: <16e16abf-a1cc-a2f7-f5bc-4158236bffe4@grimberg.me>
References: <1541349434-31640-1-git-send-email-israelr@mellanox.com>
 <fa4ec36d-29e5-3cbd-742e-33c617d0f82e@broadcom.com>
 <67c9a957-1b61-2632-396c-3c410f6729fa@mellanox.com>
 <20181107090751.GA25759@lst.de>
 <0c0b1ada-c1b2-2f27-098b-ca1859fcd485@mellanox.com>
 <20181108083751.GA3465@lst.de>
 <16e16abf-a1cc-a2f7-f5bc-4158236bffe4@grimberg.me>
Message-ID: <f43f1881-c56e-6b00-6d5a-4511faa8648d@broadcom.com>



On 11/8/2018 4:00 PM, Sagi Grimberg wrote:
>
>> No, I'm arguing that adding this just in case code which doesn't
>> have a good way to actually catch a typical bug is not very useful.
>
> Regardless of the specific error code, the question is do we want
> to be able to still continue degraded operation if we happen to fail
> queue allocation. A different error could be that we failed to connect
> because the target is overloaded..
>

That shouldn't have happened if you have already done a SET_FEATURES to 
set the io queue count.

-- james
