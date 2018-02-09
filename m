From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 9 Feb 2018 09:50:58 +0800
Subject: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and nvme_dev_disable
In-Reply-To: <20180208175606.GD5039@localhost.localdomain>
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
 <073ce416-fd26-b41a-187d-1db9210c48b0@grimberg.me>
 <20180208175606.GD5039@localhost.localdomain>
Message-ID: <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>

Hi Keith and Sagi

Many thanks for your kindly response.
That's really appreciated.

On 02/09/2018 01:56 AM, Keith Busch wrote:
> On Thu, Feb 08, 2018@05:56:49PM +0200, Sagi Grimberg wrote:
>> Given the discussion on this set, you plan to respin again
>> for 4.16?
> 
> With the exception of maybe patch 1, this needs more consideration than
> I'd feel okay with for the 4.16 release.
> 
Currently, one of the block is the nvme_wait_freeze in nvme_reset_work.
This cause some issues when I test this patchset yesterday.
As I posted on the V1 patchset mail thread:

if we set NVME_REQ_CANCELLED and return BLK_EH_HANDLED as the RESETTING case,
nvme_reset_work will hang forever, because no one could complete the entered requests.

if we invoke nvme_reset_ctrl after modify the state machine to be able to change to RESETTING
to RECONNECTING and queue reset_work, we still cannot move things forward, because the reset_work
is being executed.

if we use nvme_wait_freeze_timeout in nvme_reset_work, unfreeze and return if expires. But the 
timeout value is tricky..


And actually, one of the possible solution to fix this cleanly is blk_set_preempt_only.
It is a lightweight way to gate the new bios out of generic_make_request.

Looking forward your advice on this.
And many thanks for your precious time on this.

Sincerely
Thanks
Jianchao
