From: joshi.k@samsung.com (Kanchan Joshi)
Date: Fri, 25 Jan 2019 19:50:50 +0530
Subject: [PATCH v2 0/4] Write-hint for FS journal
In-Reply-To: <20190124082933.GA12184@quack2.suse.cz>
References: <CGME20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17@epcas2p4.samsung.com>
 <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
 <20190124082933.GA12184@quack2.suse.cz>
Message-ID: <fb13c936-aa6c-46af-7d35-72548b5baaab@samsung.com>

Hi Jens,
Can you please have a glance on this patch series, given than attempt is 
to extend the original architecture of write-hints.

Thanks,

On Thursday 24 January 2019 01:59 PM, Jan Kara wrote:
> Hello,
> 
> On Wed 09-01-19 21:00:57, Kanchan Joshi wrote:
>> Towards supporing write-hints/streams for filesystem journal.
>>                                                                                  
>> Here is the v1 patch for background -
>> https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2
>>                                                                                  
>> Changes since v1:
>> - introduce four more hints for in-kernel use, as recommended by Dave chinner
>>    & Jens axboe. This isolates kernel-mode hints from user-mode ones.
>> - remove mount-option to specify write-hint, as recommended by Jan kara &
>>    Dave chinner. Rather, FS always sets write-hint for journal. This gets ignored
>>    if device does not support stream.
>> - Removed code-redundancy for write_dirty_buffer (Jan kara's review comment)
> 
> I guess the series should also go to Jens since he was the original author
> of write-hint support so he has the best idea about the architecture.
> 
> 								Honza
> 
>> Kanchan Joshi (4):
>>    block: Increase count of supported write-hints
>>    fs: introduce four macros for in-kernel hints
>>    fs: introduce APIs to enable sending write-hint with buffer-head
>>    fs/ext4,jbd2: add support for passing write-hint with journal.
>>
>>   fs/buffer.c                 | 18 ++++++++++++++++--
>>   fs/ext4/super.c             |  2 ++
>>   fs/jbd2/commit.c            | 11 +++++++----
>>   fs/jbd2/journal.c           |  3 ++-
>>   fs/jbd2/revoke.c            |  3 ++-
>>   include/linux/blkdev.h      |  5 ++++-
>>   include/linux/buffer_head.h |  3 +++
>>   include/linux/fs.h          |  5 +++++
>>   include/linux/jbd2.h        |  8 ++++++++
>>   9 files changed, 49 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.7.4
>>
>>
