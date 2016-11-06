From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 6 Nov 2016 23:36:55 +0200
Subject: [PATCH RFC nvme-cli 0/2] auto generate hostnqn file on
 installation
In-Reply-To: <20161106192451.GA18342@lst.de>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <20161106192451.GA18342@lst.de>
Message-ID: <5a2ee2fb-8104-39cc-1af3-f0fca1caa48e@grimberg.me>


>> Not sure if it's the best way to do this as my packeging understanding is
>> very limited, hence the RFC. the debian part is tested (don't have
>> access to rpm distros at the moment).
>
> My idea was to add a command to generate an automatic hostnqn to
> the nvme tool instead, what would you think about that?

I'm fine with that too.

> The install scripts could then call that.

Sounds fine.
