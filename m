From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Dec 2017 12:10:15 +0200
Subject: How to Persistent nvme Storage?
In-Reply-To: <CADL4p-oTfz2+0G-+mDsCDoom+4VJ_aZgbasYwQ35UsxrEaW7wA@mail.gmail.com>
References: <CADL4p-oX+AojAs-rSL5CY_p2hZYaK_cJ+Px+NkVeKhh428OUDw@mail.gmail.com>
 <8b1b3096-5c03-6f8d-b3f2-fe0cfa025a5b@grimberg.me>
 <CADL4p-r1bLz4jM_YoJbanBVE3kPDuoy35iJyRGPSt7KATYUeDQ@mail.gmail.com>
 <66c5e406-6f4f-497f-9633-f1d85de7e303@grimberg.me>
 <CADL4p-qifp4VXTJuh6GkHsuMdFSCeHOYvXM7-+QuMTOq3imMtA@mail.gmail.com>
 <5b609220-cb69-6995-6422-5f203bfb3cfb@grimberg.me>
 <CADL4p-pT6TpmYz5fCmJQQAFQzuttX=h20V-ROoHV67a9C-XMJg@mail.gmail.com>
 <CADL4p-oTfz2+0G-+mDsCDoom+4VJ_aZgbasYwQ35UsxrEaW7wA@mail.gmail.com>
Message-ID: <25635e6f-ad24-06a2-ac06-db86c784fc05@grimberg.me>

Please check your kernel .config includes CONFIG_NVME_MULTIPATH=y
and your kernel version.
