From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 23:54:15 -0700
Subject: [PATCH] adjust serial number form u64 to u8[20]
In-Reply-To: <5b5e1a0c-5b3c-fb5a-97b1-cf776943af34@huawei.com>
References: <1540810606-17252-1-git-send-email-lijie34@huawei.com>
 <739c3b0a-25e5-bcdb-0589-a95d33ea3958@grimberg.me>
 <d244b7d7-8880-4dac-ca07-b45bf91b69e9@huawei.com>
 <ca5606a7-2320-637d-d6f0-53b515dd2785@grimberg.me>
 <5b5e1a0c-5b3c-fb5a-97b1-cf776943af34@huawei.com>
Message-ID: <b45f83f0-8c23-f372-8944-5142deae9d65@grimberg.me>


> Hi sagi,
> 
> If the original value of SN has already met the ASCII string requirement?other places to use serial number can be directly used without conversion.It would be better.
> In addition, if use bin2hex to convert when sending it to host, the original value input by nvmet_subsys_attr_serial_store will be different from the value of nvme list at the host side.

Well of course it needs to be hex2bin...

I don't mind all that much, but please if you are in the area, make the
default serial a 20-byte serial number.
