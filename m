From: m.malygin@yadro.com (Mikhail Malygin)
Date: Fri, 16 Aug 2019 08:37:36 +0000
Subject: [PATCH] nvmet: read device size in identify-ns command handler
In-Reply-To: <5fdce872-8e34-f34e-6ae8-e67bc2f935ac@grimberg.me>
References: <20190813093157.21755-1-m.malygin@yadro.com>
 <5fdce872-8e34-f34e-6ae8-e67bc2f935ac@grimberg.me>
Message-ID: <A6E7616B-75C7-4C02-B93B-8FF44DE86642@yadro.com>

Rescan may be triggered manually from the initiator side. It would good to have rescan tiggered automatically, 
however I did not find a way to notify nvmet about block size change. 

> On 15 Aug 2019,@20:03, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> 
>> Currently device size is cached in ns->size field on namespace enable, so
>> any device size change after that can't bee seen by initiator.
>> This patch updates ns->size field in identify-ns command handler,
>> so initiator can see new device size after ns-rescan.
> 
> What would trigger a ns rescan?
