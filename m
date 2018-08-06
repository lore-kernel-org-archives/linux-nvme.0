From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 6 Aug 2018 21:39:24 +0000
Subject: [PATCH] nvme-cli add ns write protect support
In-Reply-To: <1533289737.2982.5.camel@gmail.com>
References: <20180803024343.4088-1-chaitanya.kulkarni@wdc.com>
 <1533289737.2982.5.camel@gmail.com>
Message-ID: <57988F0C-D1C5-46EE-BD18-61898FCE4710@wdc.com>

Thanks for the comment Minwoo, I?ll send out the next version soon.

On 8/3/18, 2:49 AM, "Minwoo Im" <minwoo.im.dev@gmail.com> wrote:

    Hi Chaitanya,
    
    On Thu, 2018-08-02@19:43 -0700, Chaitanya Kulkarni wrote:
    > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
    
    > @@ -1549,6 +1573,7 @@ char *nvme_status_to_string(__u32 status)
    >  	case NVME_SC_SANITIZE_FAILED:		return "SANITIZE_FAILED: The most recent sanitize operation failed and no recovery actions has been successfully completed";
    >  	case NVME_SC_SANITIZE_IN_PROGRESS:	return "SANITIZE_IN_PROGRESS: The requested function is prohibited while a sanitize operation is in progress";
    >  	case NVME_SC_LBA_RANGE:			return "LBA_RANGE: The command references a LBA that exceeds the size of the namespace";
    > +	case NVME_SC_NS_WRITE_PROTECTED:	return "Namespace Write Protected";
    
    Not bad, but if you don't mind, can we change the description to something
    like below just like the others.
    
    NS_WRITE_PROTECTED: The command is prohibited while the namespace is write
                        protected by the host.
    
    This sentence is exactly as it is in TP 4005a.
    
    Thanks,
    	Minwoo Im
    
