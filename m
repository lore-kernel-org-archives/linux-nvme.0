From: marc.smith@mcc.edu (Marc Smith)
Date: Fri, 31 Mar 2017 09:26:32 -0400
Subject: Linux 4.9.8 + NVMe CiB Issue
In-Reply-To: <20170310002745.GH14329@localhost.localdomain>
References: <CAHkw+LcMtBp_xC6YdR-c=P-feZJvukNtkeEWueJ_y9wkAg2hUA@mail.gmail.com>
 <20170215211240.GA23472@localhost.localdomain>
 <CAHkw+Lfy-3b+Dg4Bwfg1ViBSNrWsiiuBSXJTcu2VQNdfBRcB0g@mail.gmail.com>
 <CAHkw+LfthNu5Bs5xFNw3YRNmTHxFpea1E_W--f4ZVvd_gnMs0g@mail.gmail.com>
 <CAHkw+Lem6EzvxwPYK+5R02rdDARzNxjCKGZXc-vDzLcdj8FJnQ@mail.gmail.com>
 <CAHkw+Ldp4C+we2sCJ1EjcAquA0JcCwf91T0Pq0DThmRU3EwLVQ@mail.gmail.com>
 <20170310002745.GH14329@localhost.localdomain>
Message-ID: <CAHkw+LdOnTdwpSR8=aefeLk51aUCg9NzsDSJdT1t-S97jP0tng@mail.gmail.com>

Just an update in case anyone else stumbles upon this thread with the
same issue: Intel reviewed the logs from the drives and determined the
NVMe drives are hitting their maximum operating temperature and then
shutting down.

--Marc

On Thu, Mar 9, 2017@7:27 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, Mar 09, 2017@03:25:01PM -0500, Marc Smith wrote:
>> Hi,
>>
>> We opened a support case with Intel (# 02641251) but we aren't making
>> much progress... they looked at log files from /var/log/ on our system
>> and now seem to be blaming warning/error log lines from
>> Corosync/Pacemaker on the issue. =)
>>
>> We're still able to reproduce this issue with high load... the NVMe
>> drives "drop out", randomly, not always the same drive, when pushing
>> I/O across all of our NVMe drives.
>>
>> We don't mind to keep pushing on the Intel NVMe hardware support
>> front, but looking for confirmation that its believed based on the
>> kernel log messages posted, that this is an issue with the NVMe drives
>> themselves (eg, firmware)?
>
> This genuinely looks like the drives have stopped responding and needs
> to be directed to the drive vendor.
