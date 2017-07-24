From: sathya.prakash@broadcom.com (Sathya Prakash Veerichetty)
Date: Mon, 24 Jul 2017 16:21:36 -0600
Subject: Test Unit Ready translation seems wrong in latest driver
In-Reply-To: <20170724220153.GB11979@localhost.localdomain>
References: <706a68b8482154bdf77efe7fb195fe24@mail.gmail.com>
 <20170724220153.GB11979@localhost.localdomain>
Message-ID: <99d24253f526a6f8f6ca4c9883dde14a@mail.gmail.com>

My bad, I was referring to 4.12.  So there will not be any support to SCSI
translation at all or is there a different interface?

Thanks
Sathya

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com]
Sent: Monday, July 24, 2017 4:02 PM
To: Sathya Prakash Veerichetty
Cc: linux-nvme at lists.infradead.org; hch at lst.de
Subject: Re: Test Unit Ready translation seems wrong in latest driver

On Mon, Jul 24, 2017 at 03:52:16PM -0600, Sathya Prakash Veerichetty
wrote:
> The TUR translation returns LUN not ready when the controller is ready
> in the latest code whereas in the old code it returns LUN not ready
> only when the controller is not ready (proper behavior).

The latest code doesn't have a translation for TUR at all.
