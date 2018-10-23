From: lijie34@huawei.com (lijie (AC))
Date: Tue, 23 Oct 2018 15:02:57 +0800
Subject: [PATCH] nvmet:added support for identifying controller list
In-Reply-To: <52246ba4-0b38-b129-edda-e6bc18165e5e@grimberg.me>
References: <1540265095-11360-1-git-send-email-lijie34@huawei.com>
 <52246ba4-0b38-b129-edda-e6bc18165e5e@grimberg.me>
Message-ID: <7a927786-cd97-63e3-b2a2-561492580db8@huawei.com>

Hi Sagi,
When I use the nvme list-ctrl command, it doesn't work because the
target side doesn't support querying the controller list. So I added
these codes to the target side.

On 2018/10/23 14:24, Sagi Grimberg wrote:
> 
>> This patch implements the support for identifying controller list and
>> namespace attached controller list on the target.
> 
> Can you explain why is this needed? Or where is this going?
> These are mandatory only for namespace management support which is
> not in nvmet.
> 
> 
