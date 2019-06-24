From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 24 Jun 2019 16:51:39 -0700
Subject: [PATCH v3 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <yq136jyo927.fsf@oracle.com>
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-3-bvanassche@acm.org> <yq1a7eeusa5.fsf@oracle.com>
 <68786de5-cdd8-c6d8-98a7-8a4310dac789@acm.org> <yq1blyrpupw.fsf@oracle.com>
 <7e51e415-16af-2fc5-42e9-ebd0e6f94c0e@acm.org> <yq136jyo927.fsf@oracle.com>
Message-ID: <062c6877-62e3-a37b-d2b2-ea35aadae912@acm.org>

On 6/24/19 4:30 PM, Martin K. Petersen wrote:
> 
> Hi Bart,
> 
>> As you must have noticed the patch at the start of this thread touches
>> both the bdev and the file backends. So I'm not sure what your
>> question is about?
> 
> I was contemplating what the observed I/O atomicity would be for the
> initiator side when the target file backend is using buffered I/O.

Hi Martin,

My understanding is that after a completion has been reported for an 
atomic NVMe write that the written data must survive a power cycle. As 
you probably know all single logical block NVMe writes are atomic since 
the AWUPF field is 0's based. So I don't think that it is possible to 
implement a backend that uses buffered I/O in such a way that the 
backend is NVMe compliant without using an uninterruptible power supply.

Bart.
