From: smj@fastmail.com (Sam McLeod)
Date: Fri, 15 Apr 2016 09:38:45 +1000
Subject: I/O 0 QID 0 timeout,
 disable controller - kernel 4.4 / 4.5 NVMe controller dropouts
In-Reply-To: <570FF797.2000109@fb.com>
References: <1DC99E13-F6CB-4B7F-AFD7-187825DEE523@fastmail.com>
 <20160414132113.GA21794@localhost.localdomain> <570FA450.7080105@fb.com>
 <20160414152326.GA12458@infradead.org> <570FF797.2000109@fb.com>
Message-ID: <9EB299CB-C271-4F3D-A91A-5D3F5BD7C120@fastmail.com>

Thank you all involved, is there anything we can set in the mean time to prevent this or do you suggest rolling back to a much older kernel?

Sent from my iPhone

> On 15 Apr 2016,@6:03 AM, Jens Axboe <axboe@fb.com> wrote:
> 
>> On 04/14/2016 09:23 AM, Christoph Hellwig wrote:
>> The code in the 4.7 tree still falls back to legacy irqs, it just tries
>> MSI-X first, then MSI, then legacy.  Which seems a common patters in
>> MSI-X using drivers, as I've just started a tree wide audit for the
>> usage of the MSI/MSI-X APIs.
> 
> Yeah, that seems sane. OK, let's queue it up for 4.6, it's sucks to have known broken behavior like the current out there.
> 
> -- 
> Jens Axboe
> 
