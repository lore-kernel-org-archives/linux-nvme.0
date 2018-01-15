From: kai.heng.feng@canonical.com (Kai Heng Feng)
Date: Mon, 15 Jan 2018 19:18:10 +0800
Subject: 960 evo + APST
In-Reply-To: <1516014692.300.1235638048.4627AF31@webmail.messagingengine.com>
References: <1516014692.300.1235638048.4627AF31@webmail.messagingengine.com>
Message-ID: <9AA08A54-06CB-4EF3-BD46-74456C276496@canonical.com>

> 
> On 15 Jan 2018,@7:11 PM, Joshua Bonnett <me@joshuabonnett.com> wrote:
> 
> Really sorry to bother you guys, I am trying to nail down the pm961/sm961/ 960 evo APST bug and I have a dell xps 15 9560 here with a pm961 and it needed APST turned off completely as well and not just turned down. I am just wondering if you tested the 960 evo throughly in any other motherboards or laptops?   Thanks! 

Do you mean that disabling PS4 doesn?t help?

Disable APST completely is not desirable for a laptop.

Please attach the output of `sudo nvme get-feature -f 0x0c -H /dev/nvme0`
and `sudo nvme id-ctrl /dev/nvme0`, thanks.

Kai-Heng

> 
> 
> (let me know if you want me to just leave you be, and I will just wander off to buy some drives or something, no hard feelings) 
