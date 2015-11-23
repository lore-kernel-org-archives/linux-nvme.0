From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Mon, 23 Nov 2015 21:09:47 +0100
Subject: nvme lightnvm comments
In-Reply-To: <20151123195306.GA18448@infradead.org>
References: <20151120105022.GA22131@infradead.org>
 <20151121111210.GA19360@infradead.org> <565206C3.3000200@bjorling.me>
 <20151123154557.GA20924@infradead.org>
 <20151123160319.GA7208@localhost.localdomain>
 <20151123195306.GA18448@infradead.org>
Message-ID: <5653728B.4030004@bjorling.me>

On 11/23/2015 08:53 PM, Christoph Hellwig wrote:
> On Mon, Nov 23, 2015@04:03:20PM +0000, Keith Busch wrote:
>> We also thought it'd have been cleaner to have a different command set,
>> but the committee hasn't taken on assigning these reserved bits for any
>> new purposes yet. LightNVM detection is done with the vendor + device
>> id at the moment.
>
> I saw the vendor + device, but even with that I'd rather see a reserved
> value in the command set in addition.  Claiming that we're NVM if we're
> not is a bad idea.
>

Well, I would too. However, we can't add a new mode without breaking 
compatibility at some other point in time. We're working on the 
standardization process.
