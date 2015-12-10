From: elliott@hpe.com (Elliott, Robert (Persistent Memory))
Date: Thu, 10 Dec 2015 01:40:04 +0000
Subject: [PATCHv3] printf: Add format for 8-byte EUI-64 type
In-Reply-To: <1449702413-25598-1-git-send-email-keith.busch@intel.com>
References: <1449702413-25598-1-git-send-email-keith.busch@intel.com>
Message-ID: <94D0CD8314A33A4D9D801C0FE68B40295BE8E7F2@G4W3202.americas.hpqcorp.net>


> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Keith Busch
> Sent: Wednesday, December 9, 2015 5:07 PM
...
> Subject: [PATCHv3] printf: Add format for 8-byte EUI-64 type
> 
...
> @@ -1496,6 +1496,8 @@ char *pointer(const char *fmt, char *buf, char
> *end, void *ptr,
>  	case 'm':			/* Contiguous: 000102030405 */
>  					/* [mM]F (FDDI) */
>  					/* [mM]R (Reverse order; Bluetooth) */
> +					/* [mM]l (EUI-64) */
> +					/* [mM][FM]l (FDDI/Reverse order EUI-64) */

Should that be [FR] rather than [FM]?


---
Robert Elliott, HPE Persistent Memory
