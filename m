From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 2 Jul 2018 10:36:40 -0600
Subject: PCIe unsupported request with Intel 760p
In-Reply-To: <20180525232009.GV11037@localhost.localdomain>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com>
 <20180525232009.GV11037@localhost.localdomain>
Message-ID: <20180702163640.GB22877@localhost.localdomain>

Unfortunately the development team says they will not be able to provide
a fix for this errata. When using this device in a platform that reacts
this way to an LTR message (hopefully these are very few nowadays), the
recommendation is either disable ASPM or set the Unsupported Request bit
in the root port's AER Uncorrectable Error Mask register.
