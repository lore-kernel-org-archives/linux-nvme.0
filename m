From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 14 Jul 2015 20:48:29 -0700
Subject: [PATCH] NVMe: Reread partitions on metadata formats
In-Reply-To: <55A559B5.2000303@fb.com>
References: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
 <55A559B5.2000303@fb.com>
Message-ID: <CAA9_cmc2Kb=XRwPpOijT+T_1-qfPH-h7LeM0AGSP6ZOW72MjwQ@mail.gmail.com>

On Tue, Jul 14, 2015@11:49 AM, Jens Axboe <axboe@fb.com> wrote:
> On 07/14/2015 11:57 AM, Keith Busch wrote:
>>
>> This patch has the driver automatically reread partitions if a namespace
>> has a separate metadata format. Previously revalidating a disk was
>> sufficient to get the correct capacity set on such formatted drives,
>> but partitions that may exist would not have been surfaced.
>
>
> Looks sane to me. Paul, does this fix your issue?

NVDIMM namespaces with metadata space will run into this same problem.
Why not make revalidate_disk re-read partitions?
