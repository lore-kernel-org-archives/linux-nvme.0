From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Dec 2017 09:25:09 +0200
Subject: How to Persistent nvme Storage?
In-Reply-To: <CADL4p-r1bLz4jM_YoJbanBVE3kPDuoy35iJyRGPSt7KATYUeDQ@mail.gmail.com>
References: <CADL4p-oX+AojAs-rSL5CY_p2hZYaK_cJ+Px+NkVeKhh428OUDw@mail.gmail.com>
 <8b1b3096-5c03-6f8d-b3f2-fe0cfa025a5b@grimberg.me>
 <CADL4p-r1bLz4jM_YoJbanBVE3kPDuoy35iJyRGPSt7KATYUeDQ@mail.gmail.com>
Message-ID: <66c5e406-6f4f-497f-9633-f1d85de7e303@grimberg.me>


> Thanks .
> 
>        Merry Christmas?I'm sorry to bother you at the festival, but I
> really need your help, I downloaded the latest nvme-cli version,
> currently 1.4, I use two ib cards to connect to the same device, but I
> do not know how to use it Multipathing binds these two nvme
> devices.Hope to receive your reply?Thanks

run: nvme list-subsys

you can see the expected output in the man pages.
