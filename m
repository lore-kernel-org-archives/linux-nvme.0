From: axboe@fb.com (Jens Axboe)
Date: Mon, 6 Feb 2017 09:44:53 -0700
Subject: [PATCH v6 0/3] SED OPAL Library
In-Reply-To: <1486151432-3431-1-git-send-email-scott.bauer@intel.com>
References: <1486151432-3431-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1ac62773-df21-2523-02ee-ec82af5458b2@fb.com>

On 02/03/2017 12:50 PM, Scott Bauer wrote:
> Changes from v5->v6:
> 
> 1) Fixed comments from last review From Christoph
> 2) Rebased code on top of Jens' for-next
> 3) Explicitly aligned the structs in the uapi
> 
> ===============================================================================
> This Patch series implements a large portion of the Opal protocol for
> self encrypting devices. The driver has the capability of storing a
> locking range's password. The password can then be replayed
> during a resume from previous suspend-to-RAM.
> 
> The driver also supports logic to bring the device out of a factory
> default-inactive state into a functional Opal state.
> 
> The following logic is supported in order to bring the tper into a
> working state:
> 
> 1) Taking Ownership of the drive (Setting the Admin CPIN).
> 2) Activating the Locking SP (In Single User Mode or Normal Mode).
> 3) Setting up Locking Ranges (Single User or Normal Mode).
> 4) Adding users to Locking Ranges (Normal Mode Only).
> 5) Locking or Unlocking Locking Ranges (Single User Mode or Normal Mode).
> 6) Reverting the TPer (Restore to factory default).
> 7) Setting LR/User passwords (Single User Mode or Normal Mode).
> 8) Enabling/disabling Shadow MBR.
> 9) Enabling Users in the LockingSP (Normal Mode Only).
> 10) Saving Password for resume from suspend.
> 11) Erase and Secure erasing locking ranges.

Applied for 4.11, thanks.

-- 
Jens Axboe
