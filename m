From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 8 Aug 2016 11:45:16 +0300
Subject: [PATCH RFC nvme-cli 4/4] fabrics: Allow discover params to come
 from a conf file
In-Reply-To: <20160808070342.GD12598@lst.de>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
 <1470572365-20674-5-git-send-email-sagi@grimberg.me>
 <20160808070342.GD12598@lst.de>
Message-ID: <a65d2044-2e70-6612-0645-5bb1fa2ed65c@grimberg.me>


>> Allow the user to just run "nvme discover" or "nvme connect-all"
>> in case it finds a default /etc/nvme/nvmf_disc conf file.
>>
>> We allow multiple discovery addresses by iterating over the
>> lines of the file and executing a discover (with or without
>> connect) for each line. We allow newlines and '#' prefixed comments.
>>
>> The return value is or'ed on all discover attempts.
>>
>> In order to minimize some parsing code, I just convert the
>> file line into an (argc, argv) pair and feed it to argconfig_parse()
>> which dictates that the file lines are identical to what one would
>> pass nvme discover <params>. I'm open to better ideas.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>> Not sure if anyone will find this useful, but worth a
>> shot.
>
> Looks ok to me.

I'll settle for ok :)

> While the options are an odd config file format
> having them the same as the command line at least makes it easy
> to document both in one spot.

It was the easiest for me in terms of parsing (or non-parsing to
be exact).
