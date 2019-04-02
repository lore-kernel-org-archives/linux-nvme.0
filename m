From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 2 Apr 2019 15:06:02 +0300
Subject: [PATCH 1/2] nvmet: make MDTS value configurable
In-Reply-To: <c42e4c4e-51bb-b255-b242-e68594bc160a@suse.de>
References: <20190329120404.55637-1-hare@suse.de>
 <20190329120404.55637-2-hare@suse.de>
 <3bfa0c56-91d1-a722-df92-1ed4744f04ad@mellanox.com>
 <9abfa47a-3374-a1a0-8370-1096d02743d0@suse.com>
 <20190401031036.GB11565@localhost.localdomain>
 <c42e4c4e-51bb-b255-b242-e68594bc160a@suse.de>
Message-ID: <91c8f4a1-8bb6-adac-4206-e65d778cc2b1@mellanox.com>


On 4/1/2019 2:48 PM, Hannes Reinecke wrote:
> On 4/1/19 5:10 AM, Keith Busch wrote:
>> On Sun, Mar 31, 2019@07:02:40PM -0700, Hannes Reinecke wrote:
>>>> I think it's more of a ctrl/nvmet_port configuration than a subsystem.
>>>>
>>>> For example if you have 2 HCAs, one is super strong and can transfer
>>>> upto 8MB and the second is old model and can transfer upto 64KiB.
>>>>
>>>> do
>>>>
>>>> id->mdts = ctrl->ops->port_mdts(req->port);
>>>>
>>>> and inside the implementation you can do
>>>>
>>>> min_not_zero(max_port_hca_cap_in_mdts_units, mdts_configfs_val);
>>>>
>>>> and it will fix the comment that is written above (we're not really
>>>> unlimited).
>>>>
>>>> this way we're using the low level device characteristics and also 
>>>> cover
>>>> the bio split test.
>>>>
>>>> thoughts ?
>>>>
>>>>
>>> Yeah, true, it should be a port configuration.
>>>
>>> I'll be updating the patch.
>>
>> Wouldn't this indicate MDTS should be driven from hardware constraints
>> rather than user tunable knobs? I don't think we should have user
>> parameters if their only purpose is to test how host drivers react
>> to them. It's okay if they've a functional purpose, but there are so
>> many adjustable nvme parameters, this is a bit of a slippery slope if we
>> want to turn the nvme target driver into a host driver test vehicle.
>>
> I would love to indicate hardware constraints to nvme target; there's 
> a similar problem I'm facing in that the hardware is using only a 
> limited set of queues, but I cannot express this with nvme target.
> However, in the absense of such an interface having a manual 
> configuration allows us to at least _map_ onto the hardware capabilities.

my suggestion exactly check the HW constraint.

My suggestion also makes sure that a greedy user will get a clamp and an 
economical user can save resources at the target.

Let's say I have a very "weak" target server with super HCA 
(ConnectX-5), so in that case I would like to set mdts=4 (or so) and let 
the initiator block layer to deal with 1MB IO splits.

Keith,

although NVMe has many params, I guess we can make some of the most 
vital ones to be tunable.

I agree regarding code adaptation for test-cases (we shouldn't change 
driver in order to write tests), but in this case it's a real world 
scenario.

>
> But I don't really buy the 'too many parameters' objection.

we need to take that into consideration as well and expose only vital 
params (we don't want to have hundreds of configfs entries as iSCSI)


> What _is_ the point of the software target if we cannot tweak it to 
> test out certain corner cases in the spec?
>
> Cheers,
>
> Hannes


-Max.
