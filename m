From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Mar 2018 15:45:58 -0700
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries for
 hidden controllers"
In-Reply-To: <20180307150344.GE30975@localhost.localdomain>
References: <20180307131358.20275-1-hch@lst.de>
 <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
 <20180307150344.GE30975@localhost.localdomain>
Message-ID: <20180308224558.GA14765@localhost.localdomain>

On Wed, Mar 07, 2018@08:03:45AM -0700, Keith Busch wrote:
> On Wed, Mar 07, 2018@02:40:39PM +0100, Hannes Reinecke wrote:
> > How do we detect the topology now?
> > Does nvme cli has the functionality?
> 
> Not in the way you'd probably like. It can provide all the information
> you'd need to put it together, but it doesn't provide a convenient
> method to get or visualize it. I'll add a note on the project to fix
> that.

Actually, nvmecli already has something kind of close, thanks
to Johannes! The 'list-subsys' command is most of the way there. It
currently looks like this, and just needs to go one level deeper to
append the namespaces to the output:

# nvme list-subsys -o json
{
  "Subsystems" : [
    {
      "Name" : "nvme-subsys0",
      "NQN" : "nqn.2014.08.org.nvmexpress:8086108ePHLE7200015N6P4B7335943:ICDPC5ED2ORA6.4T"
    },
    {
      "Paths" : [
        {
          "Name" : "nvme0",
          "Transport" : "pcie",
          "Address" : "0000:03:00.0"
        },
        {
          "Name" : "nvme1",
          "Transport" : "pcie",
          "Address" : "0000:04:00.0"
        }
      ]
    }
  ]
}

While this should readily work for fabrics, I needed to add a new kernel
driver patch to export the PCIe address for the above (patch staged
for 4.17).
