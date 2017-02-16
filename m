From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Thu, 16 Feb 2017 23:54:16 +0000
Subject: [PATCH] nvme-cli: fabrics: Fix to pass "host_traddr" to the
 kernel driver.
In-Reply-To: <fec0b817-0ebd-0e49-b04d-9601ce516fe6@grimberg.me>
References: <n> <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
 <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>
 <A4F3AC48-4E31-49F4-9498-6A65C3659EF1@cavium.com>
 <fec0b817-0ebd-0e49-b04d-9601ce516fe6@grimberg.me>
Message-ID: <07574210-2E0C-4455-9FF3-6D7D5B7DE3DA@cavium.com>

I have not tried the fc target loopback.  But since the discovery response is processed above the fc transport level it should return the same information for the host to process.  (ie transport type FC etc).  

The connection to the target, from the host perspective, would be the same.  

Darren Trapp
Senior Director - Engineering
darren.trapp at cavium.com <mailto:darren.trapp at caviumnetworks.com>
T 949-389-6273
M 949-212-8576
26650 Aliso Viejo Pkwy, Aliso Viejo, CA 92656
www.qlogic.com <http://www.qlogic.com/>
 <http://www.qlogic.com/>

On 2/16/17, 6:17 AM, "Sagi Grimberg" <sagi@grimberg.me> wrote:

    
    > FC requires the host_traddr to make the connection.  If it wasn?t provided, the fc transport wouldn?t have been able to connect to the discovery controller and request the disc page.  Hence, we wouldn?t be here parsing the response.
    
    Did you test this patch with nvme-loop?
    
