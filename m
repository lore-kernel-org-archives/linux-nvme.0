From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Wed, 15 Feb 2017 17:00:49 +0000
Subject: [PATCH] nvme-cli: fabrics: Fix to pass "host_traddr" to the
 kernel driver.
In-Reply-To: <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>
References: <n> <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
 <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>
Message-ID: <A4F3AC48-4E31-49F4-9498-6A65C3659EF1@cavium.com>

FC requires the host_traddr to make the connection.  If it wasn?t provided, the fc transport wouldn?t have been able to connect to the discovery controller and request the disc page.  Hence, we wouldn?t be here parsing the response.  

Darren Trapp
Senior Director - Engineering
darren.trapp at cavium.com <mailto:darren.trapp at caviumnetworks.com>
T 949-389-6273
M 949-212-8576
26650 Aliso Viejo Pkwy, Aliso Viejo, CA 92656
www.qlogic.com <http://www.qlogic.com/>
 <http://www.qlogic.com/>

On 2/15/17, 1:56 AM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    
    > @@ -595,6 +595,11 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
    >  				return -EINVAL;
    >  			p += len;
    >
    > +			len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
    > +			if (len < 0)
    > +				return -EINVAL;
    > +			p+= len;
    > +
    
    I think this needs to be conditional on if provided at all.
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
