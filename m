From: mr.nuke.me@gmail.com (Alex G.)
Date: Fri, 6 Apr 2018 14:08:38 -0500
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <20180406180445.GL10098@localhost.localdomain>
References: <719ea777-e57d-511e-52c5-cf83027d1fd0@gmail.com>
 <20180405224138.GH10098@localhost.localdomain>
 <20180405224830.GI10098@localhost.localdomain>
 <20180405230515.GJ10098@localhost.localdomain>
 <75edea4e-b961-82a1-3612-fc682a248819@gmail.com>
 <d9497570-5e5e-cc4d-2c63-ff273a48725a@gmail.com>
 <20180406153236.GK10098@localhost.localdomain>
 <94d77cb7-759f-595a-2264-37305dfa96c4@gmail.com>
 <20180406171622.aso3h6ydpmcdizl3@sbauer-Z170X-UD5>
 <93003ab7-f4a0-7e5d-f107-277df20f5566@gmail.com>
 <20180406180445.GL10098@localhost.localdomain>
Message-ID: <e1218a86-2183-91c9-5a0a-a1c331b5b5f3@gmail.com>

On 04/06/2018 01:04 PM, Keith Busch wrote:
> On Fri, Apr 06, 2018@12:46:06PM -0500, Alex G. wrote:
>> On 04/06/2018 12:16 PM, Scott Bauer wrote:
>>> You're using AER inject, right?
>>
>> No. I'm causing the errors in hardware with hot-unplug.
> 
> I think Scott's still on the right track for this particular sighting.
> The AER handler looks unsafe under changing topologies. It might need run
> under pci_lock_rescan_remove() before walking the bus to prevent races
> with the surprise removal, but it's not clear to me yet if holding that
> lock is okay to do in this context.

I think we have three mechanisms that can remove a device: nvme timeout,
Link Down interrupt, and AER.
Link Down comes 20-60ms after the link actually dies, in which time nvme
will queue IO, which can cause a flood of PCIe errors, which trigger AER
handling. I suspect there is a massive race condition somewhere, but I
don't yet have convincing evidence to prove it.

> This however does not appear to resemble your previous sightings. In your
> previous sightings, it looks like something has lost track of commands,
> and we're freeing the resources with them a second time.

I think they might be related.

Alex
