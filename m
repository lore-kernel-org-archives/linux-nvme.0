From: jsmart2021@gmail.com (James Smart)
Date: Thu, 18 Jul 2019 18:20:41 -0700
Subject: [PATCH 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <5669f502-e931-d0ed-71f7-91d3fca01816@grimberg.me>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
 <20190716211241.7650-11-jsmart2021@gmail.com>
 <2bd2a068-dbbd-84e8-250e-d9d4afa640d3@suse.de>
 <5669f502-e931-d0ed-71f7-91d3fca01816@grimberg.me>
Message-ID: <3a2ddff8-d900-1eee-2179-43539fcc1383@gmail.com>

On 7/18/2019 5:33 PM, Sagi Grimberg wrote:
> 
>> The install sequence is slightly odd, but not enough to complain.
> 
> Whats odd the udevadm vs. systemctl?
> 
>> (udevadm trigger before systemd daemon-reload? I'd rather do it the
>> other way round. Anyway.)
> 
> Why? just out of curiosity?

I assume it's - if you load udev first, it can trigger systemd services 
that don't exit yet. Thus cleaner to have systemd setup then udev 
enabled to call it.

-- james
