From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 18 Jul 2019 09:55:09 -0600
Subject: [PATCH blktests v2 03/12] nvme: Add new test to verify the
 generation counter
In-Reply-To: <20190718070330.GC15760@x250.microfocus.com>
References: <20190717171259.3311-1-logang@deltatee.com>
 <20190717171259.3311-4-logang@deltatee.com>
 <20190718070330.GC15760@x250.microfocus.com>
Message-ID: <1c81c160-7c32-7a88-53ae-ea54030b8d19@deltatee.com>



On 2019-07-18 1:03 a.m., Johannes Thumshirn wrote:
> On Wed, Jul 17, 2019@11:12:50AM -0600, Logan Gunthorpe wrote:
> [...]
>> +_discovery_genctr() {
>> +	nvme discover -t loop |
>> +		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>> +}
> 
> Sorry for not having spotted this in v1, but do we really want to hard-core
> the transport type in a library function?

My opinion is that this is unnecessary until we have users of the
function that need different transport types. It's easy enough for
someone to change when they need it. It's a pretty standard practice in
kernel development to not add a feature that no-one uses.

Logan
