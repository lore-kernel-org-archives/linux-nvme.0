From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 Aug 2016 11:06:47 -0400
Subject: Linux AER reporting
In-Reply-To: <CAG3=cO=ux5+EeDSCxDiEtSscH0UJ=+pJr4Exunvw=rfGai-zNA@mail.gmail.com>
References: <CAG3=cOncMTcyALa=-i1jeA-z4pe22D9CrJ=Rxr2E8HWBsEMOPg@mail.gmail.com>
 <57BB4019.7050008@linux.vnet.ibm.com>
 <CAG3=cOn_pMZ5DMtB3K2tDGUL1x3vkn=Vjw9c8X8+ONh8xef+mw@mail.gmail.com>
 <57BDA906.4050207@linux.vnet.ibm.com>
 <20160824144029.GA13258@localhost.localdomain>
 <CAG3=cO=ux5+EeDSCxDiEtSscH0UJ=+pJr4Exunvw=rfGai-zNA@mail.gmail.com>
Message-ID: <20160825150646.GE13337@localhost.localdomain>

On Wed, Aug 24, 2016@10:13:43AM -0700, Nisha Miller wrote:
> Hi Keith,
> 
> I'm not injecting any errors. I'm trying to see if AER reporting can
> help me diagnose the problem. Is this something AER can help me do or
> am I on the wrong track here?

Is there anything else in the dmesg occuring when you observe the ff's
CSTS register value? That status usually (only?) happens if the device
link is disconnected or broken.
