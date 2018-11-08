From: lijie34@huawei.com (lijie (AC))
Date: Thu, 8 Nov 2018 14:44:08 +0800
Subject: [PATCH] adjust serial number form u64 to u8[20]
In-Reply-To: <b45f83f0-8c23-f372-8944-5142deae9d65@grimberg.me>
References: <1540810606-17252-1-git-send-email-lijie34@huawei.com>
 <739c3b0a-25e5-bcdb-0589-a95d33ea3958@grimberg.me>
 <d244b7d7-8880-4dac-ca07-b45bf91b69e9@huawei.com>
 <ca5606a7-2320-637d-d6f0-53b515dd2785@grimberg.me>
 <5b5e1a0c-5b3c-fb5a-97b1-cf776943af34@huawei.com>
 <b45f83f0-8c23-f372-8944-5142deae9d65@grimberg.me>
Message-ID: <02cf434e-313d-aa0e-d8a2-d905aeae334b@huawei.com>



On 2018/10/31 14:54, Sagi Grimberg wrote:
> 
>> Hi sagi,
>>
>> If the original value of SN has already met the ASCII string requirement?other places to use serial number can be directly used without conversion.It would be better.
>> In addition, if use bin2hex to convert when sending it to host, the original value input by nvmet_subsys_attr_serial_store will be different from the value of nvme list at the host side.
> 
> Well of course it needs to be hex2bin...
> 
> I don't mind all that much, but please if you are in the area, make the
> default serial a 20-byte serial number.
> 
> 
Hi sagi,
	
Then use 10 bytes to generate a random number. When bin2hex is passed, a 20-byte serial number will be generated. Like this:

	char serial[10];

	get_random_bytes(&serial, sizeof(serial));
	memset(subsys->sn, ' ', sizeof(subsys->sn));
	bin2hex(subsys->sn, &serial, min(sizeof(serial), sizeof(subsys->sn) / 2));

Thanks a lot.
Lijie
