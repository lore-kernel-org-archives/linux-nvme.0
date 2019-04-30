From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Apr 2019 22:18:23 -0700
Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover
 args
In-Reply-To: <5c4f7927-7475-34dc-2876-5db2cfb0a259@intel.com>
References: <20190429225338.6866-1-sagi@grimberg.me>
 <5c4f7927-7475-34dc-2876-5db2cfb0a259@intel.com>
Message-ID: <bd5354e8-1655-c873-d8e3-de393e886cd6@grimberg.me>


>> +??????? argc = 0;
>> +??????? argv[argc++] = "dummy";
>> +??????? while ((ptr = strsep(&args, " =\n")) != NULL)
> 
> There might be an issue here because args will be updated each time to
> point to the next position in the string after the current token. When
> you go to 'free' args, the pointer may no longer be valid.

Yea... We need another pointer for that...
