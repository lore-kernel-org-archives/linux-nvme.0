From: krisman@collabora.co.uk (Gabriel Krisman Bertazi)
Date: Tue, 30 May 2017 15:30:46 -0300
Subject: WARNING triggers at blk_mq_update_nr_hw_queues during
 nvme_reset_work
In-Reply-To: <20170530175549.GC2845@localhost.localdomain> (Keith Busch's
 message of "Tue, 30 May 2017 13:55:49 -0400")
References: <8760giqnyb.fsf@dilma.collabora.co.uk>
 <20170530175549.GC2845@localhost.localdomain>
Message-ID: <87bmqanqnd.fsf@dilma.collabora.co.uk>

Keith Busch <keith.busch at intel.com> writes:

> On Tue, May 30, 2017@02:00:44PM -0300, Gabriel Krisman Bertazi wrote:
>> Since the merge window for 4.12, one of the machines in Intel's CI
>> started to hit the WARN_ON below at blk_mq_update_nr_hw_queues during an
>> nvme_reset_work.  The issue persists with the latest 4.12-rc3, and full
>> dmesg from boot, up to the moment where the WARN_ON triggers is
>> available at the following link:
>> 
>> https://intel-gfx-ci.01.org/CI/CI_DRM_2672/fi-kbl-7500u/igt at kms_pipe_crc_basic@suspend-read-crc-pipe-a.html
>> 
>> Please notice that the test we do in the CI involves putting the
>> machine to sleep (PM), and the issue triggers when resuming execution.
>> 
>> I have not been able to get my hands on the machine yet to do an actual
>> bisect, but I'm wondering if you guys might have an idea of what is
>> wrong.
>> 
>> Any help is appreciated :)
>
> Hi Gabriel,
>
> This appears to be new behavior in blk-mq's tag set update with commit
> 705cda97e. This is asserting a lock is held, but none of the drivers
> that call the export are take that lock.
>
> I think the below should fix it (CC'ing block list and developers).
>

Thanks for the quick fix, Keith.  I'm running it against the CI to
confirm it fixes the issue and will send you my tested-by once the job
is completed.

-- 
Gabriel Krisman Bertazi
