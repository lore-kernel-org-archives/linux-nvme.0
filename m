From: sbates@raithlin.com (Stephen Bates)
Date: Mon, 21 Nov 2016 20:45:13 -0600
Subject: Introducing Unit test framework based on nvme-cli
In-Reply-To: <20161117160511.GH10050@localhost.localdomain>
References: <1477550917-6472-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175828.GA1207@infradead.org>
 <20161116183522.GB10050@localhost.localdomain>
 <1479325410.31236.0.camel@linux.intel.com>
 <20161116213733.GE10050@localhost.localdomain>
 <257502b9-3373-c6aa-cbf4-a0a276d2dd59@grimberg.me>
 <20161117160511.GH10050@localhost.localdomain>
Message-ID: <ca55487bd73a1f999146a99c66d3e0c8.squirrel@webmail.raithlin.com>

>>
>> Usually when building a package we don't want to run tests
>> that require nvme devices. So until we can classify to tests that have
>> requirements to not run unless some env variables are set we need:
>
> Okay, I see. Thanks for the update, I've applied the fix with
> Christoph's review.
>
>

Hmmm I *thought* I had commented on this series and sent a reply to
linux-block. Ah well, my points were minor and I am glad this has made it
into name-cli.

Cheers

Stephen
