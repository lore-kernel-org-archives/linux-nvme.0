From: hch@lst.de (Christoph Hellwig)
Date: Tue, 6 Dec 2016 09:28:08 +0100
Subject: [PATCH 1/3] nvmet: delete controllers deletion upon subsystem
 release
In-Reply-To: <72c13127-830a-e3b1-c10c-6992da0502e8@grimberg.me>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-2-git-send-email-sagi@grimberg.me>
 <20161205154039.GC6529@lst.de>
 <72c13127-830a-e3b1-c10c-6992da0502e8@grimberg.me>
Message-ID: <20161206082808.GB12194@lst.de>

On Mon, Dec 05, 2016@07:08:03PM +0200, Sagi Grimberg wrote:
>
>>> No reason for them to be kept around if we are
>>> deleting the subsystem, so instead of passively
>>> wait for the host to disconnect, actively delete
>>> the controllers.
>>
>> Looks fine, but I'd really love to see a testcase for this in some form..
>
> Should we revive the selftests branch?

As-is it's not very usable and would need some major rework.  At some
point Chaitanya mentioned he wanted to look into it, but I suspect
he is busy with other things at the moment.

Personally I think we should use nvme-cli and nvmetcli for our tests
instead of opencoding everything, and life would probably be easier
if we wrote it in a proper test framework similar to the nvme-cli
and nvmetcli tests.
