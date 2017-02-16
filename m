From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Feb 2017 16:17:53 +0200
Subject: [PATCH] nvme-cli: fabrics: Fix to pass "host_traddr" to the
 kernel driver.
In-Reply-To: <A4F3AC48-4E31-49F4-9498-6A65C3659EF1@cavium.com>
References: <n> <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
 <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>
 <A4F3AC48-4E31-49F4-9498-6A65C3659EF1@cavium.com>
Message-ID: <fec0b817-0ebd-0e49-b04d-9601ce516fe6@grimberg.me>


> FC requires the host_traddr to make the connection.  If it wasn?t provided, the fc transport wouldn?t have been able to connect to the discovery controller and request the disc page.  Hence, we wouldn?t be here parsing the response.

Did you test this patch with nvme-loop?
