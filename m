From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 6 Nov 2016 23:41:41 +0200
Subject: [PATCH RFC nvme-cli 1/2] debain: generate hostnqn file on install
 and remove on uninstall
In-Reply-To: <20161106192530.GB18342@lst.de>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <1478459581-22654-2-git-send-email-sagi@grimberg.me>
 <20161106192530.GB18342@lst.de>
Message-ID: <67cdf4dd-3638-8faf-7512-0ef39ca464a3@grimberg.me>

> I think the subject should read "debian" :)

Probably :)

>> diff --git a/debian/prerm b/debian/prerm
>> new file mode 100644
>> index 000000000000..40c6fea42284
>> --- /dev/null
>> +++ b/debian/prerm
>> @@ -0,0 +1,5 @@
>> +#!/bin/sh
>> +
>> +if [ "$1" = "remove" ]; then
>> +    rm -rf /etc/nvme
>> +fi
>
> Shouldn't we only do that for a purge?

I haven't given it much thought, it really was a 15 minute
thing that I thought I'd through out here so people can
tell suggest how to do it better...

I know rpms have .rpmsave for these sort of files but not
sure what are the rules for debian.
