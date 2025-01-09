-- Create a Constraint to Through an error if a value found in the rental.customer_id column is deleted from the customer table.
ALTER TABLE rental
ADD CONSTRAINT fk_rental_customer_id FOREIGN KEY (customer_id)
REFERENCES customer (customer_id) ON DELETE RESTRICT;

-- Create a Multicolumn index on the payment table
CREATE INDEX idx_payment01 
ON payment (payment_date, amount);

-- Add a UNIQUE Index
ALTER TABLE vehicle
ADD UNIQUE INDEX idx_VIN (VIN);

-- Add a UNIQUE Index with 2 values
ALTER TABLE vehicle
ADD UNIQUE idx_vehicleId_and_VIN (vehicle_id, VIN);