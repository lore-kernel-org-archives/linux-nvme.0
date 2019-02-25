From: keith.busch@intel.com (Keith Busch)
Date: Mon, 25 Feb 2019 08:55:01 -0700
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
Message-ID: <20190225155501.GI10237@localhost.localdomain>

On Sun, Feb 24, 2019@03:27:09PM -0800, Alex_Gagniuc@Dellteam.com wrote:
> 
> More like "fatal error, just panic". It looks like this (from a serial 
> console):
> 
> [   57.680494] {1}[Hardware Error]: Hardware error from APEI Generic  Hardware Error Source: 1
> [   57.680495] {1}[Hardware Error]: event severity: fatal
> [   57.680496] {1}[Hardware Error]:  Error 0, type: fatal
> [   57.680496] {1}[Hardware Error]:   section_type: PCIe error
> [   57.680497] {1}[Hardware Error]:   port_type: 6, downstream switch port
> [   57.680498] {1}[Hardware Error]:   version: 3.0
> [   57.680498] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
> [   57.680499] {1}[Hardware Error]:   device_id: 0000:3c:07.0
> [   57.680499] {1}[Hardware Error]:   slot: 1
> [   57.680500] {1}[Hardware Error]:   secondary_bus: 0x40
> [   57.680500] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x9733
> [   57.680501] {1}[Hardware Error]:   class_code: 000406
> [   57.680502] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, > control: 0x0003

This is a reaction to a ERR_FATAL message, right? What happens if we
ignore firmware first and override control of the AER masking with a
set to the Unsupported Request Error Mask in the root and downstream
ports? You can do a quick test like this for the above's hardware:

  # setpci -s 3c:07.0 ECAP_AER+8.l=100000:100000

You'd probably have to do the same command to the root port BDf, and any
other switches you have them in the hierarchy. 
