From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Wed, 17 May 2017 14:56:36 +0200 (CEST)
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <20170515170506.GK3616@mtr-leonro.local>
References: <33e2cc35-f147-d4a4-9a42-8f1245e35842@mellanox.com>
 <DE927C68B458BE418D582EC97927A92855088C6F@ORSMSX113.amr.corp.intel.com>
 <82dd5b24-5657-ae5e-8a33-646fddd8b75b@grimberg.me>
 <20170515133122.GG3616@mtr-leonro.local>
 <9465cd0c-83db-b058-7615-5626ef60dbb0@grimberg.me>
 <20170515143632.GH3616@mtr-leonro.local>
 <20170515145952.GA7871@infradead.org>
 <20170515170506.GK3616@mtr-leonro.local>
Message-ID: <779753075.36035391.1495025796237.JavaMail.zimbra@kalray.eu>

> On Mon, May 15, 2017@07:59:52AM -0700, Christoph Hellwig wrote:
>> On Mon, May 15, 2017@05:36:32PM +0300, Leon Romanovsky wrote:
>> > I understand you and both Max and me are feeling the same as you. For more
>> > than 2 months, we constantly (almost on daily basis) asked for a solution from
>> > architecture group, but received different answers. The proposals were
>> > extremely broad from need for strong fence for all cards to no need for
>> > strong fence at all.
>>
>> So let's get the patch to do a strong fence everywhere now, and relax
>> it later where possible.
>>
>> Correntness before speed..
> 
> OK, please give me and Max till EOW to stop this saga. One of the two
> options will be: Max will resend original patch, or Max will send patch
> blessed by architecture group.
> 

Good luck with this Max & Leon! It seems to be a complicated problem.
Just an idea: in our case it *seems* that the problem started appearing
after a firmware upgrade, older ones do not seem to have the same
behaviour. Maybe it's a hint for you.

Thanks!
Marta
